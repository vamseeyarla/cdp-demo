#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Usage: copyData.sh {datalake_name}"
    exit 1
fi

DATA_LAKE_ROOT=s3a://cloudbreak-group/user/rvenkatesh/dls/$1/data
hdfs dfs -mkdir $DATA_LAKE_ROOT
hdfs dfs -copyFromLocal /tmp/retail_clickstream/ $DATA_LAKE_ROOT
