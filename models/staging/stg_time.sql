with source as (
  select * from {{ source('raw_data', 'dim_time') }}
)
select
  time_id,
  date,
  day_of_week,
  month,
  quarter,
  year,
  week_of_year
from source
