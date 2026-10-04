{# yml_valid_region:
	- ASP 
    - PAC
    #}
{% set region = var('yml_valid_region')[0] %}

{% set full_region = var('yml_valid_region') %}

-- in select

-- SELECT 
--     '{{ var("yml_valid_region") | first }}' AS selected_region

-- SELECT 
--     '{{ var("yml_valid_region")[0] }}' AS selected_region

-- SELECT 
--      '{{ region }}' AS selected_region


 -- in filter 

--  SELECT 'columns' as reg 
-- From  selected_region
-- Where region='{{region}}'    

-- in select
-- SELECT 
--     '{{ full_region[0] }}' AS selected_region


-- in filter
 
   SELECT 'columns' as reg 
 From  selected_region
 Where region in ('{{ full_region | join(" ' , '")}}')


