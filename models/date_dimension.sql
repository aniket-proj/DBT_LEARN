with cte as (
    select 
    to_timestamp(STARTED_AT) as STARTED_AT,
    Date (to_timestamp(STARTED_AT)) as DATE_STARTED_AT,
    HOUR(to_timestamp(STARTED_AT)) AS HOUR_STARTED_AT,

    CASE 
    WHEN DAYNAME(to_timestamp(STARTED_AT)) IN ('sat','sun')
    then 'WEEKEND'
    ELSE 'BUSINESSDAY'
    END AS DAY_TYPE,

    CASE 
    WHEN MONTH(to_timestamp(STARTED_AT)) IN (12,1,2)
    THEN 'WINTER'
    WHEN MONTH(to_timestamp(STARTED_AT)) IN (3,4,5)
    THEN 'SPRING'
    WHEN  MONTH(to_timestamp(STARTED_AT)) IN (6,7,8)
    THEN 'SUMMER'
    ELSE 'AUTUMN'
    END AS STATION_OF_YEAR 
    
    from
    {{ source('demo', 'bike') }}
    where STARTED_AT != 'started_at'
)

select * from cte
