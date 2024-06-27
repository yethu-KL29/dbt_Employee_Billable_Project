-- models/average_billable_percentage.sql
with utilization as (
  select
    ru.employee_id,
    e.employee_name,
    t.year,
    t.quarter,
    t.month,
    avg(ru.utilization_percentage) as avg_utilization_percentage
  from {{ ref('stg_resource_utilization') }} ru
  join {{ ref('stg_employee') }} e on ru.employee_id = e.employee_id
  join {{ ref('stg_time') }} t on ru.time_id = t.time_id
  where ru.active = true
  group by ru.employee_id, e.employee_name, t.year, t.quarter, t.month
)

select
  year,
  quarter,
  month,
  avg(avg_utilization_percentage) as avg_billable_percentage
from utilization
group by year, quarter, month
order by year, quarter, month
