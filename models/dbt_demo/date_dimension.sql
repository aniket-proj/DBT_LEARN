with cte as (
    select 
    to_timestamp(STARTED_AT) as STARTED_AT,
    Date (to_timestamp(STARTED_AT)) as DATE_STARTED_AT,
    HOUR(to_timestamp(STARTED_AT)) AS HOUR_STARTED_AT,
    {{DAY_TYPE('started_at')}} as DAY_TYPE,
    {{GET_SEASON('started_at')}} AS STATION_OF_YEAR,
    {{ function1('started_at') }} AS TIME_FLAG
    from
    {{ source('demo', 'bike') }}
    where STARTED_AT != 'started_at'
)

select * from cte
