#!/bin/sh
set -e
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
DEMO_DATA_ROOT_DIR=${SCRIPTPATH}/..
echo "Creating HDFS directories..."
su - hdfs -c "hdfs dfs -mkdir -p /user/insurance_admin && hdfs dfs -chown insurance_admin /user/insurance_admin"
su - hdfs -c "hdfs dfs -mkdir -p /user/marketing_admin && hdfs dfs -chown marketing_admin /user/marketing_admin"
su - hdfs -c "hdfs dfs -mkdir -p /sko_demo_data/structured"
echo "Copying data to HDFS..."
su - hdfs -c "hdfs dfs -put ${DEMO_DATA_ROOT_DIR}/structured/* /sko_demo_data/structured/"
echo "Setting ownership..."
su - hdfs -c "hdfs dfs -chown -R marketing_admin /sko_demo_data/structured/marketing_campaigns"
su - hdfs -c "hdfs dfs -chown -R insurance_admin /sko_demo_data/structured/hortonia_bank"
echo "Setting hive data..."
beeline -u jdbc:hive2://localhost:10000/default -n insurance_admin -p admin -f ${DEMO_DATA_ROOT_DIR}/scripts/hortonia_create_ddl.sql
beeline -u jdbc:hive2://localhost:10000/default -n marketing_admin -p admin -f ${DEMO_DATA_ROOT_DIR}/scripts/marketing-campaign-ddl-script.sql
echo "Verifying hive data..."
echo "count(us_customers)..."
beeline -u jdbc:hive2://localhost:10000/default -n insurance_admin -p admin -e "select count(*) from hortoniabank.us_customers;"
echo "count(clickstream)..."
beeline -u jdbc:hive2://localhost:10000/default -n marketing_admin -p admin -e "select count(*) from marketing.clickstream;"
echo "Setting up lineage..."
beeline -u jdbc:hive2://localhost:10000/default -n marketing_admin -p admin -e "use marketing; create table clickstream_campaigns as select clickstream.product_id, clickstream.campaign_id, campaigns.mobile_optimized from clickstream join campaigns on campaigns.campaign_id=clickstream.campaign_id limit 10;"
