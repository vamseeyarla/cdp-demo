#!/bin/bash

DATA_LAKE_ROOT=s3a://cloudbreak-group/user/rvenkatesh/dls/e2e-public-demo/data
hdfs dfs -mkdir $DATA_LAKE_ROOT
hdfs dfs -copyFromLocal retail_clickstream/ DATA_LAKE_ROOT
