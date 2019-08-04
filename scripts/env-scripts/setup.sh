#!/bin/bash

set +x

export CB_PROFILE=dev

dp env create from-file --file cdp-demo1-env.json --name cdp-demo1

dp sdx create \
        --name cdp-demo1 \
        --description "Ram's very first data lake" \
        --env-name  cdp-demo1\
        --cluster-shape LIGHT_DUTY \
        --cloud-storage-base-location "s3a://cloudbreak-group/user/rvenkatesh/dls/cdp-demo-dl-1-dev" \
        --cloud-storage-aws-instance-profile "arn:aws:iam::980678866538:instance-profile/mock-idbroker-assumer" \
        --with-external-database

dp distrox create --cli-input-json de-cluster.json --name rv-test-1

dp distrox create --cli-input-json de-latest.json --name rv-de-latest-1

dp distrox create --cli-input-json dm-cluster.json --name rv-dm-test-1

dp distrox create --cli-input-json dm-latest.json --name rv-dm-latest-1
