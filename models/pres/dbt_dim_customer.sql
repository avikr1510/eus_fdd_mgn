{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='customer_id',
    tags=['scd1']
) }}

with stg as (
    select 
        customer_id, 
        customer_name, 
        email, 
        country, 
         etl_last_updated_date 
    from 

{{ ref('dbt_stg_customer') }}

    {%- if is_incremental() %}
    where etl_last_updated_date > (select NVL(max(end_date), '1900-01-01 00:00:00')::timestamp from {{ this }})
    {% endif -%}
)
,
insert_record as (

    select 
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk,
        customer_id, 
        customer_name, 
        email, 
        country, 
        etl_last_updated_date as start_date,
        sysdate() as end_date,
        'TRUE' as is_current
    from 
    stg
    )

select * from insert_record