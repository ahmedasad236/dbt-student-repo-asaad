with raw_reviews as (
    select * from {{ source('airbnb', 'reviews') }}
)

select
    comments as review_text,
    date as review_date,
    listing_id,
    reviewer_name,
    sentiment as review_sentiment
from raw_reviews