create external table if not exists campaigns(
	campaign_id int,
	gender_preference string,
	mobile_optimized boolean,
	optimal_hour int,
	promoted_product_id int
)
COMMENT 'This table contains marketing campaigns information.' 
row format delimited fields terminated by '|'
LOCATION 's3a://REPLACE_BUCKET_NAME_HERE/data/marketing_campaigns/campaigns'
TBLPROPERTIES('department'='Marketing');

create external table if not exists clickstream(
	click_time timestamp,
	ip string,
	product_id int,
	campaign_id int,
	cookie string,
	platform string,
	tracking_id_internal int
)
COMMENT 'This table contains clickstream information collected from users' 
row format delimited fields terminated by '|'
LOCATION 's3a://REPLACE_BUCKET_NAME_HERE/data/marketing_campaigns/clickstream'
TBLPROPERTIES('department'='Marketing');

create external table if not exists sales(
	sale_time timestamp,
	customer_id int,
	product_id int,
	promotion_id int,
	cookie string,
	tracking_id_internal int
)
COMMENT 'This table contains sales information generated from sales' 
row format delimited fields terminated by '|'
LOCATION 's3a://REPLACE_BUCKET_NAME_HERE/data/marketing_campaigns/sales'
TBLPROPERTIES('department'='Marketing');

create external table if not exists users(
	customer_id int,
	customer_name string,
	customer_gender string,
	customer_ccn string,
	customer_city string,
	customer_state string,
	customer_zip string,
	customer_email string,
	customer_phone string
)
COMMENT 'This table contains information about users.' 
row format delimited fields terminated by '|'
LOCATION 's3a://REPLACE_BUCKET_NAME_HERE/data/marketing_campaigns/users'
TBLPROPERTIES('department'='Marketing');
