{{ config(materialized='view') }}

with base as (
    select 
        ru.resource_utilization_id,
        ru.time_id,
        ru.employee_id,
        ru.project_id,
        ru.department_id,
        ru.utilization_hours,
        ru.utilization_percentage,
        ru.active
    from 
        {{ source('raw_data', 'fact_resource_utilization') }} ru
    where 
        ru.active = true
)

select * from base
