#!/bin/bash

set +x

dp sdx create \
        --name cdp-latest-public \
        --description "Public datalake" \
        --env-name  cdp-latest-public\
        --cluster-shape LIGHT_DUTY \
        --cloud-storage-base-location "s3a://cloudbreak-group/user/rvenkatesh/dls/cdp-latest-public" \
        --cloud-storage-aws-instance-profile "arn:aws:iam::980678866538:instance-profile/mock-idbroker-assumer" \
        --with-external-database
