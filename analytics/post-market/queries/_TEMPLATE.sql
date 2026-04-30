-- Post-Market Surveillance Query: [Description]
-- Author: [Name]
-- Date: [YYYY-MM-DD]
-- Data source: [Table/system name]
--
-- Replace all [brackets] with your values.

WITH complaints AS (
    SELECT
        [date_column] AS complaint_date,
        [device_column] AS device_id,
        [category_column] AS complaint_category,
        [severity_column] AS severity
    FROM [complaints_table]
    WHERE [date_column] >= DATEADD(month, -[N], CURRENT_DATE)
)
SELECT
    DATE_TRUNC('month', complaint_date) AS month,
    complaint_category,
    COUNT(*) AS complaint_count,
    COUNT(*) * 1000.0 / [device_days] AS complaints_per_1000_days
FROM complaints
GROUP BY 1, 2
ORDER BY 1 DESC, 3 DESC;
