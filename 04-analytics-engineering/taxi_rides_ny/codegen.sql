{% set models_to_generate = codegen.get_models(directory='core', prefix='fact_fhv_trips') %}
{{ codegen.generate_model_yaml(
    model_names = models_to_generate
) }}