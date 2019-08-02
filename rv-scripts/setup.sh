#!/bin/bash

set +x

dp env create from-file --file cdp-demo1-env.json --profile dev

dp sdx create \
        --name cdp-demo1 \
        --description "Ram's very first data lake" \
        --env-name  cdp-demo1\
        --cluster-shape LIGHT_DUTY \
        --cloud-storage-base-location "s3a://cloudbreak-group/user/rvenkatesh/dls/cdp-demo-dl-1-dev" \
        --cloud-storage-aws-instance-profile "arn:aws:iam::980678866538:instance-profile/mock-idbroker-assumer" \
        --with-external-database \
        --cidr "0.0.0.0/0" --profile dev

dp distrox create --cli-input-json de-cluster.json --name rv-test-1 --profile dev
