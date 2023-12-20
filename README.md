# DK_Snowflake_Compute_Scaling_Example
Welcome to the Snowflake Compute Scaling Demo. This demo showcases how you can easily scale the compute in Snowflake.
The sample data set used in this query for this demo are provided in the SNOWFLAKE_SAMPLE_DATA shared database.

Setup
-- Create warehouse
<img width="1704" alt="image" src="https://github.com/durandkwok-snowflake/DK_Snowflake_Compute_Scaling_Example/assets/109616231/bf6b896c-a9e5-4b27-89e0-625fb8dca1b9">
<img width="509" alt="image" src="https://github.com/durandkwok-snowflake/DK_Snowflake_Compute_Scaling_Example/assets/109616231/98997499-70dc-4830-8f63-63a51a28a160">

Make sure the warehouse is in suspend mode to flush out the cache and make sure the warehouse is not active

<img width="1447" alt="image" src="https://github.com/durandkwok-snowflake/DK_Snowflake_Compute_Scaling_Example/assets/109616231/f2fc3532-6446-41bd-b83b-bf7512cc41b4">

Create five SQL worksheet tabs in Snowsight



<img width="157" alt="image" src="https://github.com/durandkwok-snowflake/DK_Snowflake_Compute_Scaling_Example/assets/109616231/feecc512-90eb-4ba3-8ade-d17370930447">

Each of the tabs corresponds to a session. So copy and paste the following code to each of the five tabs:


<img width="1693" alt="image" src="https://github.com/durandkwok-snowflake/DK_Snowflake_Compute_Scaling_Example/assets/109616231/5ec16f1b-7b27-462d-8b7f-598d52d2d833">

use database snowflake_sample_data;
use schema tpch_sf1000;
use warehouse voya_test;

ALTER SESSION SET USE_CACHED_RESULT = FALSE;


SELECT
    p.p_partkey,
    p.p_name,
    p.p_brand,
    p.p_type,
    p.p_size,
    SUM(CASE WHEN DATEDIFF(DAY,CURRENT_DATE, o.o_orderdate) <= 30 THEN l.l_quantity ELSE 0 END) AS last_30_days_qty,
    SUM(CASE WHEN DATEDIFF(DAY, CURRENT_DATE, o.o_orderdate) > 30 AND DATEDIFF(DAY, CURRENT_DATE, o.o_orderdate) <= 60 THEN l.l_quantity ELSE 0 END) AS last_31_60_days_qty,
   SUM(CASE WHEN DATEDIFF(DAY, CURRENT_DATE, o.o_orderdate) > 60 AND DATEDIFF(DAY, CURRENT_DATE, o.o_orderdate) <= 90 THEN l.l_quantity ELSE 0 END) AS last_61_90_days_qty,
   SUM(CASE WHEN DATEDIFF(DAY, CURRENT_DATE, o.o_orderdate) > 90 THEN l.l_quantity ELSE 0 END) AS over_90_days_qty
FROM
    part p
JOIN
    lineitem l ON p.p_partkey = l.l_partkey
JOIN
    orders o ON l.l_orderkey = o.o_orderkey
GROUP BY
    p.p_partkey, p.p_name, p.p_brand, p.p_type, p.p_size
ORDER BY
    p.p_partkey
