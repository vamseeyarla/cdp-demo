#!/bin/sh
set -e
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
DEMO_DATA_ROOT_DIR=${SCRIPTPATH}/..
BUCKET_NAME=s3a://REPLACE_BUCKET_NAME_HERE
REMOTE_DATA_DIR=${BUCKET_NAME}/data
HS2_URL="jdbc:hive2://REPLACE_HS2_HOST_NAME:10001/default;principal=hive/_HOST@CLOUDERA.SITE;transportMode=http;httpPath=cliservice"
echo "Loading data..."
hadoop fs -mkdir -p ${REMOTE_DATA_DIR}/sko_demo_data/structured
hadoop fs -put ${DEMO_DATA_ROOT_DIR}/structured/* /sko_demo_data/structured/
echo "Setting hive data..."
beeline -u ${HS2_URL} -f ${DEMO_DATA_ROOT_DIR}/scripts/hortonia_create_ddl.sql
beeline -u ${HS2_URL} -f ${DEMO_DATA_ROOT_DIR}/scripts/marketing-campaign-ddl-script.sql
echo "Verifying hive data..."
beeline -u ${HS2_URL} -e "select * from us_customers limit 1;"
beeline -u ${HS2_URL} -e "select * from marketing.clickstream limit 1;"
