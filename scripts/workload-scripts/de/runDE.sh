#!/bin/bash

JDBC_URL=$(grep -A2 jdbc.url.hive_on_tez /etc/hive/conf/beeline-site.xml  | grep value | sed "s/.*>\(.*\)<.*/\1/")

spark-submit --conf "spark.sql.hive.hiveserver2.jdbc.url=$JDBC_URL" --conf "spark.sql.hive.hiveserver2.jdbc.url.principal=hive/_HOST@CLOUDERA.SITE" --conf "spark.submit.pyFiles=/opt/cloudera/parcels/CDH-7.0.0-1.cdh7.0.0.p0.1352471/lib/hive_warehouse_connector/pyspark_hwc-1.0.0.7.0.0.0-424.zip" --conf spark.jars=/home/csso_eqbr/hive-warehouse-connector-assembly-1.0.0.7.0.0.0-415.modified.jar Tokenizer.py

beeline -n csso_eqbr -p Cloudera1! -f testDE.sql
