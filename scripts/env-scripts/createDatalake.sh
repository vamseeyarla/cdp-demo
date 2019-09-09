#!/bin/bash

set +x

dp sdx create \
        --name aug-23-1 \
        --description "Public datalake" \
        --env-name  aug-23-1\
        --cluster-shape LIGHT_DUTY \
        --cloud-storage-base-location "s3a://cloudbreak-group/user/rvenkatesh/dls/aug-23-1" \
        --cloud-storage-aws-instance-profile "arn:aws:iam::980678866538:instance-profile/mock-idbroker-assumer" \
        --with-external-database
