{{ 
    config(
        materialized='table',
    )
}}

with fct_reviews as (
    select * from {{ ref('fct_reviews') }}
),
full_moon_dates as (
    select * from {{ ref('seed_full_moon_dates') }}
)

select r.*,
    CASE WHEN fmd.full_moon_date IS NOT NULL
        THEN 'full moon'
        ELSE 'not full moon'
    END AS is_full_moon_review

from fct_reviews r
left join full_moon_dates fmd
    on (TO_DATE(r.review_date) = DATEADD(DAY, 1,fmd.full_moon_date))
