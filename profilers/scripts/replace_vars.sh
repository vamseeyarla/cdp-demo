#/bin/sh
set -e

if [ $# -lt 2 ]; then
	echo Usage: $0 BUCKET_NAME HS2_HOST_NAME
	exit -1
fi

BUCKET_NAME=$1
HS2_HOST_NAME=$2

sed -i 's/REPLACE_BUCKET_NAME_HERE/${BUCKET_NAME}' setup_data.sh
sed -i 's/REPLACE_HS2_HOST_NAME/${HS2_HOST_NAME}/g' setup_data.sh
sed -i 's/REPLACE_BUCKET_NAME_HERE/${BUCKET_NAME}/g' hortonia_create_ddl.sql
sed -i 's/REPLACE_BUCKET_NAME_HERE/${BUCKET_NAME}/g' marketing-campaign-ddl-script.sql