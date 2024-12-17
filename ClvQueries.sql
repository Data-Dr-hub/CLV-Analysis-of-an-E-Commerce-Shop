WITH user_registrations AS (
    SELECT
        user_pseudo_id,
        DATE_TRUNC(MIN(PARSE_DATE('%Y%m%d', event_date)), WEEK) AS registration_week,
    FROM `tc-da-1.turing_data_analytics.raw_events`
    GROUP BY user_pseudo_id),
weekly_revenue AS (
    SELECT
        user_pseudo_id,
        DATE_TRUNC(PARSE_DATE('%Y%m%d', event_date), WEEK) AS revenue_week,
        SUM(purchase_revenue_in_usd) AS revenue
    FROM `tc-da-1.turing_data_analytics.raw_events`
    WHERE event_name = 'purchase'
    GROUP BY user_pseudo_id, revenue_week)
SELECT 
    ur.registration_week, 
    SUM(CASE WHEN ur.registration_week = wr.revenue_week THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_0,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 1 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_1,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 2 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_2,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 3 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_3,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 4 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_4,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 5 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_5,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 6 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_6,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 7 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_7,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 8 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_8,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 9 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_9,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 10 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_10,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 11 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_11,
    SUM(CASE WHEN  wr.revenue_week = date_add(ur.registration_week, INTERVAL 12 week) THEN wr.revenue END)/COUNT(distinct ur.user_pseudo_id) AS Week_12
from user_registrations ur
LEFT JOIN weekly_revenue wr on ur.user_pseudo_id = wr.user_pseudo_id
group by 1
order by 1

