from pyspark.sql import SparkSession
from pyspark.sql.functions import split, regexp_extract, regexp_replace, col
import sys
import joblib


spark = SparkSession \
    .builder \
    .appName("Create Dataframe") \
    .enableHiveSupport() \
    .getOrCreate()

orders_df=spark.sql("""
  select products.product_name as product_name, concat(customers.customer_fname, ' ', customers.customer_lname) as customer_name 
    from order_items join products on products.product_id = order_items.order_item_product_id
    join orders on orders.order_id = order_items.order_item_order_id
    join customers on customers.customer_id = orders.order_customer_id
    """)

local_df = orders_df.toPandas()

joblib.dump(local_df, 'clickstream.pkl')