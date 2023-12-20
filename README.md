# DK_Snowflake_Compute_Scaling_Example
Welcome to the Snowflake Compute Scaling Demo. This demo showcases how you can easily scale the compute in Snowflake.
The sample data set used in this query for this demo are provided in the SNOWFLAKE_SAMPLE_DATA shared database.

Setup
-- Create warehouse
<img width="1704" alt="image" src="https://github.com/durandkwok-snowflake/DK_Snowflake_Compute_Scaling_Example/assets/109616231/bf6b896c-a9e5-4b27-89e0-625fb8dca1b9">
<img width="509" alt="image" src="https://github.com/durandkwok-snowflake/DK_Snowflake_Compute_Scaling_Example/assets/109616231/98997499-70dc-4830-8f63-63a51a28a160">


use database snowflake_sample_data;
use schema tpch_sf1000;
use warehouse voya_test;

<img width="1447" alt="image" src="https://github.com/durandkwok-snowflake/DK_Snowflake_Compute_Scaling_Example/assets/109616231/f2fc3532-6446-41bd-b83b-bf7512cc41b4">

-- Create tables for products, orders, and order lines.
