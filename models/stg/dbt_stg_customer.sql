{{ config(
    materialized='incremental',
    incremental_strategy='delete+insert',
    unique_key='customer_id',
    tags=['scd1']
) }}

with src as (
    select 
        customer_id, 
        customer_name, 
        email, 
        country, 
        sysdate() as etl_last_updated_date 
    from 
    --{{ source('SRC_DBT_RAW', 'dbt_raw_customer') }}
{{ ref('dbt_raw_customer') }}

    {%- if is_incremental() %}
    where etl_last_updated_date > (select NVL(max(etl_last_updated_date), '1900-01-01 00:00:00')::timestamp from {{ this }})
    {% endif -%}
)

select * from src