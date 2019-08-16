# Creating a role for every service with S3 access

Create a role that has S3 access, this role is going to be used by every service identity (e.g hive, ranger, etc.) and also every user which are in the admins group, and we need to set up such a trust policy that IDBroker is abl eto assume it:

```
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)
echo "Your AWS account id is: ${AWS_ACCOUNT_ID}"

# If you don't have jq in place, just set it up manually e.g:
# export AWS_ACCOUNT_ID=980678866538

export DATALAKE=cdp-latest
export DATALAKE_BUCKET=cloudbreak-group
export DATALAKE_PATH=${DATALAKE_BUCKET}/user/rvenkatesh/dls/${DATALAKE}
export IDBROKER_ROLE=idbroker-${DATALAKE}
export DATALAKE_ADMIN_ROLE=dladmin-${DATALAKE}
export DATALAKE_DATAENG_ROLE=dataeng-${DATALAKE}
export DATALAKE_DATASCI_ROLE=datasci-${DATALAKE}
export DATALAKE_LOG_ROLE=log-${DATALAKE}
export S3GUARD_TABLE=cdp-${DATALAKE}
export DATALAKE_COMMON_POLICY=${DATALAKE}-common
export DATALAKE_S3GUARD_POLICY=${DATALAKE}-s3guard

cat << TRUSTPOLICY > s3access-role-trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${AWS_ACCOUNT_ID}:root",
          "arn:aws:iam::${AWS_ACCOUNT_ID}:role/${IDBROKER_ROLE}"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
TRUSTPOLICY

cat << DYNAMOACCESSPOLICY > dynamodb-policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SpecificTable",
            "Effect": "Allow",
            "Action": [
                "dynamodb:*"
            ],
            "Resource": "arn:aws:dynamodb:*:*:table/${S3GUARD_TABLE}"
        }
    ]
}
DYNAMOACCESSPOLICY

cat << S3ACCESSPOLICY > bucket-policy-s3access.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowListingOfDataLakeFolder",
            "Action": [
                "s3:ListBucketByTags",
                "s3:GetLifecycleConfiguration",
                "s3:GetBucketTagging",
                "s3:GetInventoryConfiguration",
                "s3:GetObjectVersionTagging",
                "s3:ListBucketVersions",
                "s3:GetBucketLogging",
                "s3:ListBucket",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketPolicy",
                "s3:GetObjectVersionTorrent",
                "s3:GetObjectAcl",
                "s3:GetEncryptionConfiguration",
                "s3:GetBucketRequestPayment",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectTagging",
                "s3:GetMetricsConfiguration",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketPolicyStatus",
                "s3:ListBucketMultipartUploads",
                "s3:GetBucketWebsite",
                "s3:GetBucketVersioning",
                "s3:GetBucketAcl",
                "s3:GetBucketNotification",
                "s3:GetReplicationConfiguration",
                "s3:ListMultipartUploadParts",
                "s3:GetObject",
                "s3:GetObjectTorrent",
                "s3:GetBucketCORS",
                "s3:GetAnalyticsConfiguration",
                "s3:GetObjectVersionForReplication",
                "s3:GetBucketLocation",
                "s3:GetObjectVersion"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::${DATALAKE_BUCKET}"
            ]
        }
    ]
}
S3ACCESSPOLICY

cat << S3ACCESSPOLICY > datalakeadmin-policy-s3access.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${DATALAKE_PATH}/*"
        }
    ]
}
S3ACCESSPOLICY

cat << S3ACCESSPOLICY > dataeng-policy-s3access.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${DATALAKE_PATH}/data"
        }
    ]
}
S3ACCESSPOLICY

cat << S3ACCESSPOLICY > datasci-policy-s3access.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${DATALAKE_PATH}/data/processed"
        }
    ]
}
S3ACCESSPOLICY

cat << S3ACCESSPOLICY > log-policy-s3access.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${DATALAKE_PATH}/logs"
        }
    ]
}
S3ACCESSPOLICY


```

# Creating the assumer role of IDBroker, create an instance profile, add this role to it
# The actual policies assumable by this role will be added later

Create an assumer policy role and instance profile for IDBroker. IDBroker will use this role to assume the above created role.

```
aws iam create-role --role-name ${IDBROKER_ROLE} --assume-role-policy-document file://idbroker-assumer-trust-policy.json

aws iam create-instance-profile --instance-profile-name ${IDBROKER_ROLE}

aws iam add-role-to-instance-profile --instance-profile-name ${IDBROKER_ROLE} --role-name ${IDBROKER_ROLE}
```
Create the common S3 bucket access and DynamoDb table access policies
```
aws iam create-policy --policy-name ${DATALAKE_COMMON_POLICY} --policy-document file://bucket-policy-s3access.json

aws iam create-policy --policy-name ${DATALAKE_S3GUARD_POLICY} --policy-document file://dynamodb-policy.json

Create an S3 access role for the datalake admin and attach policies to it

```
aws iam create-role --role-name ${DATALAKE_ADMIN_ROLE} --assume-role-policy-document file://s3access-role-trust-policy.json

aws iam create-policy --policy-name ${DATALAKE_ADMIN_ROLE} --policy-document file://datalakeadmin-policy-s3access.json

aws iam attach-role-policy --role-name ${DATALAKE_ADMIN_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_COMMON_POLICY}
aws iam attach-role-policy --role-name ${DATALAKE_ADMIN_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_S3GUARD_POLICY}
aws iam attach-role-policy --role-name ${DATALAKE_ADMIN_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_ADMIN_ROLE}

```

Create an S3 access role for the dataengineer and attach policies to it

```
aws iam create-role --role-name ${DATALAKE_DATAENG_ROLE} --assume-role-policy-document file://s3access-role-trust-policy.json

aws iam create-policy --policy-name ${DATALAKE_DATAENG_ROLE} --policy-document file://dataeng-policy-s3access.json

aws iam attach-role-policy --role-name ${DATALAKE_DATAENG_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_COMMON_POLICY}
aws iam attach-role-policy --role-name ${DATALAKE_DATAENG_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_S3GUARD_POLICY}
aws iam attach-role-policy --role-name ${DATALAKE_DATAENG_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_DATAENG_ROLE}

```

Create an S3 access role for the datascientists role and attach policies to it

```
aws iam create-role --role-name ${DATALAKE_DATASCI_ROLE} --assume-role-policy-document file://s3access-role-trust-policy.json

aws iam create-policy --policy-name ${DATALAKE_DATASCI_ROLE} --policy-document file://datasci-policy-s3access.json

aws iam attach-role-policy --role-name ${DATALAKE_DATASCI_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_COMMON_POLICY}
aws iam attach-role-policy --role-name ${DATALAKE_DATASCI_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_S3GUARD_POLICY}
aws iam attach-role-policy --role-name ${DATALAKE_DATASCI_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_DATASCI_ROLE}

```

Create an S3 access role for the log role and attach policies to it

```
aws iam create-role --role-name ${DATALAKE_LOG_ROLE} --assume-role-policy-document file://s3access-role-trust-policy.json

aws iam create-policy --policy-name ${DATALAKE_LOG_ROLE} --policy-document file://datasci-policy-s3access.json

aws iam attach-role-policy --role-name ${DATALAKE_LOG_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_COMMON_POLICY}
aws iam attach-role-policy --role-name ${DATALAKE_LOG_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_S3GUARD_POLICY}
aws iam attach-role-policy --role-name ${DATALAKE_LOG_ROLE} --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${DATALAKE_LOG_ROLE}

```
