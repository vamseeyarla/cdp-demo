#!/bin/sh

HS2_URL="jdbc:hive2://REPLACE_HS2_HOST_NAME:10001/default;principal=hive/_HOST@CLOUDERA.SITE;transportMode=http;httpPath=cliservice"
TABLES=("us_customers" "ww_customers" "eu_countries" "tax_2015" "claim_savings" "campaigns" "clickstream" "sales" "users")
SIZE=${#TABLES[@]}
SLEEP_INTERVAL=60

while true; do
	INDEX=$(($RANDOM % $SIZE))
	echo beeline -u ${HS2_URL} -e 'select * from ${TABLES[$INDEX]} limit 1;'
	sleep ${SLEEP_INTERVAL}
done