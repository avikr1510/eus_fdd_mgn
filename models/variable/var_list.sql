{% set region = var('valid_region')[0] %}

{% set set_region = ['ASP','PAC'] %}

/*
with a_select as (
-- in select
SELECT 
    '{{ region }}' AS selected_region
    )

-- in filter
   , a_filter as(SELECT 'columns' as reg 
From  selected_region
Where region='{{region}}'
)

{# for set_region#}
-- in select
,b_select as (SELECT 
    '{{set_region[0] }}' AS selected_region)

-- in filter
   ,b_filter as( SELECT 'columns' as reg 
From  selected_region
Where region in ({%- for item in set_region -%} '{{item}}' {%-  if not loop.last -%} , {%- endif -%} {%- endfor -%})
   )

{{log(" log a - var_list  compiled successfully - " ~ set_region[0],info=True)}}

{% do log("log b - var_list compiled successfully - " ~ var("valid_region")[0],info=True) %}

{% do log("log c - var_list compiled successfully - " ~ var("valid_region"),info=True) %}


*/
