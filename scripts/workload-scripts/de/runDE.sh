#!/bin/bash

JDBC_URL=$(grep -A2 jdbc.url.hive_on_tez /etc/hive/conf/beeline-site.xml  | grep value | sed "s/.*>\(.*\)<.*/\1/")

spark-submit --conf "spark.sql.hive.hiveserver2.jdbc.url=$JDBC_URL" --conf "spark.sql.hive.hiveserver2.jdbc.url.principal=hive/_HOST@CLOUDERA.SITE" --conf "spark.submit.pyFiles=/opt/cloudera/parcels/CDH/lib/hive_warehouse_connector/pyspark_hwc-1.0.0.7.0.0.0-424.zip" --conf spark.jars=/opt/cloudera/parcels/CDH/lib/hive_warehouse_connector/hive-warehouse-connector-assembly-1.0.0.7.0.0.0-424.jar Tokenizer.py

beeline -n csso_eqbr -p Cloudera1! -f testDE.sql
