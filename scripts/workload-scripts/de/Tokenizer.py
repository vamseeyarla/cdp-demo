from pyspark.sql import SparkSession
from pyspark.sql.functions import split, regexp_extract, regexp_replace, col
import sys


spark = SparkSession \
    .builder \
    .appName("Pyspark Tokenize") \
    .enableHiveSupport() \
    .getOrCreate()


input_path = 's3a://cloudbreak-group/user/rvenkatesh/dls/cdp-latest-public/data/retail_clickstream/raw/original_access_logs'
output_path = 's3a://cloudbreak-group/user/rvenkatesh/dls/cdp-latest-public/data/retail_clickstream/enriched'
database_name = 'retail_clickstream'
table_name = 'weblogs'

base_df=spark.read.text(input_path)

split_df = base_df.select(regexp_extract('value', r'([^ ]*)', 1).alias('ip'),
                          regexp_extract('value', r'(\d\d\/\w{3}\/\d{4}:\d{2}:\d{2}:\d{2} -\d{4})', 1).alias('date_logged'),
                          regexp_extract('value', r'^(?:[^ ]*\ ){6}([^ ]*)', 1).alias('url'),
                          regexp_extract('value', r'(?<=product\/).*?(?=\s|\/)', 0).alias('productstring')
                         )


filtered_products_df = split_df.filter("productstring != ''")

cleansed_products_df=filtered_products_df.select(regexp_replace("productstring", "%20", " ").alias('product'), "ip", "date_logged", "url")

#cleansed_products_df.write.mode("overwrite").format("parquet").save(output_path)

cleansed_products_df.\
  write.\
  mode("overwrite").\
  saveAsTable(database_name+'.'+table_name+'_external', format="parquet", path=output_path)

from pyspark_llap.sql import HiveWarehouseBuilder as hwc
from pyspark_llap import HiveWarehouseSession as hws

hive = hwc\
      .session(spark)\
      .build()

cleansed_products_df.write.format(hws().HIVE_WAREHOUSE_CONNECTOR).option("table", database_name+'.'+table_name+'_acid').mode("overwrite").save()
