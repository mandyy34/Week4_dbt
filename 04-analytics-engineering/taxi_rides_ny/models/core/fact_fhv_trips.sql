{{
    config(
        materialized='table'
    )
}}

with fhvdata as (
    select *, 
        'fhv' as service_type
    from {{ ref('stg_fhv_tripdata') }} where pickup_locationid is not null or dropoff_locationid is not null
),

dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select fhvdata.fhvid, 
    fhvdata.dispatching_base_num,
    fhvdata.Affiliated_base_number,
    fhvdata.SR_Flag,
    fhvdata.pickup_locationid,
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    fhvdata.dropoff_locationid,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    fhvdata.pickup_datetime, 
    fhvdata.dropoff_datetime, 
    
from fhvdata
inner join dim_zones as pickup_zone
on fhvdata.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhvdata.dropoff_locationid = dropoff_zone.locationid