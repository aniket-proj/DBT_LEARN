with daily_weather as (
    select 
    date(time) as daily_weather,
    weather,
    temp,
    pressure,
    humidity,
    clouds
    from 
    {{ source('demo', 'weather') }}
    
),

daily_weather_agg as (
    select
    daily_weather, 
    weather,
    ROUND(AVG(temp),2) AS AVG_TEMP,
    ROUND(AVG(pressure),2) AS AVG_PRESSURE,
    ROUND(AVG(humidity),2) AS AVG_HUMIDITY,
    ROUND(AVG(clouds),2) AS AVG_CLOUDS
    from daily_weather
    group by daily_weather,weather
    QUALIFY  row_number() OVER (partition by daily_weather order by count(weather) desc) = 1
)

select  * from daily_weather_agg