with trips as (
    select 
    ride_id, 
    rideable_type,
    date (to_timestamp(started_at)) AS TRIP_DATE,
    START_STATIO_ID AS START_STATION_ID,
    END_STATION_ID,
    TIMESTAMPDIFF(SECOND,to_timestamp(started_at),TO_TIMESTAMP(ENDED_AT)) AS TRIP_DURATION
    from {{ source('demo', 'bike') }}
   
     where STARTED_AT != 'started_at'
)
select * from trips