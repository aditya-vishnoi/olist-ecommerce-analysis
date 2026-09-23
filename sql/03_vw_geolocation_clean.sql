
CREATE VIEW geolocation_clean AS
SELECT
    geolocation_zip_code_prefix,
    AVG(geolocation_lat) AS avg_lat,
    AVG(geolocation_lng) AS avg_lng
FROM geolocation_dataset
WHERE geolocation_lat BETWEEN -34 AND 6
  AND geolocation_lng BETWEEN -74 AND -32
GROUP BY geolocation_zip_code_prefix;


select count(*) from geolocation_clean

