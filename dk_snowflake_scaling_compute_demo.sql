use database snowflake_sample_data;
use schema tpch_sf1000;
use warehouse SCALING_TEST_WH;

ALTER SESSION SET USE_CACHED_RESULT = FALSE;

-- Change 4

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
;

