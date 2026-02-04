SELECT * FROM netflix_streaming_data
  SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS user_id_nulls,
  SUM(CASE WHEN title_name IS NULL THEN 1 ELSE 0 END) AS title_name_nulls,
  SUM(CASE WHEN genre IS NULL THEN 1 ELSE 0 END) AS genre_nulls,
  SUM(CASE WHEN watch_duration_min IS NULL THEN 1 ELSE 0 END) AS watch_duration_nulls,
  SUM(CASE WHEN completion_rate IS NULL THEN 1 ELSE 0 END) AS completion_rate_nulls
FROM netflix_streaming_data;

SELECT user_id, title_id, watch_date, COUNT(*) AS cnt
FROM netflix_streaming_data
GROUP BY user_id, title_id, watch_date
HAVING COUNT(*) > 1;


DELETE FROM netflix_streaming_data
WHERE ctid NOT IN (
  SELECT MIN(ctid)
  FROM netflix_streaming_data
  GROUP BY user_id, title_id, watch_date);
  
  SELECT DISTINCT device
FROM netflix_streaming_data;

SELECT DISTINCT subscription_type
FROM netflix_streaming_data;
  
UPDATE netflix_streaming_data
SET device = 'TV'
WHERE device IN ('Smart TV', 'Television', 'tv');

SELECT
  MIN(watch_duration_min) AS min_watch,
  MAX(watch_duration_min) AS max_watch
FROM netflix_streaming_data;

SELECT *
FROM netflix_streaming_data
WHERE completion_rate < 0 OR completion_rate > 1;

UPDATE netflix_streaming_data
SET completion_rate = 1
WHERE completion_rate > 1;

UPDATE netflix_streaming_data
SET
  genre = INITCAP(genre),
  country = INITCAP(country);


ALTER TABLE netflix_streaming_data
ADD COLUMN engagement_level VARCHAR(20);

UPDATE netflix_streaming_data
SET engagement_level =
  CASE
    WHEN completion_rate >= 0.8 THEN 'High'
    WHEN completion_rate >= 0.4 THEN 'Medium'
    ELSE 'Low'
  END;

SELECT
  COUNT(*) AS total_rows,
  AVG(watch_duration_min) AS avg_watch_time,
  AVG(completion_rate) AS avg_completion
FROM netflix_streaming_data;

SELECT * FROM netflix_streaming_data





