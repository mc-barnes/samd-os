-- Product Metrics Query: [Description]
-- Author: [Name]
-- Date: [YYYY-MM-DD]
-- Data source: [Table/system name]
--
-- Replace all [brackets] with your values.

WITH usage AS (
    SELECT
        [user_column] AS user_id,
        [device_column] AS device_id,
        [timestamp_column] AS event_time,
        [event_column] AS event_type
    FROM [events_table]
    WHERE [timestamp_column] >= DATEADD(day, -[N], CURRENT_DATE)
)
SELECT
    DATE_TRUNC('week', event_time) AS week,
    COUNT(DISTINCT user_id) AS active_users,
    COUNT(DISTINCT device_id) AS active_devices,
    COUNT(*) AS total_events
FROM usage
GROUP BY 1
ORDER BY 1 DESC;
