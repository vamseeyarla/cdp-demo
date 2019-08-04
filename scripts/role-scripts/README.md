# Creating a role for every service with S3 access

Create a role that has S3 access, this role is going to be used by every service identity (e.g hive, ranger, etc.) and also every user which are in the admins group, and we need to set up such a trust policy that IDBroker is abl eto assume it:

```
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)
echo "Your AWS account id is: ${AWS_ACCOUNT_ID}"

# If you don't have jq in place, just set it up manually e.g:
# export AWS_ACCOUNT_ID=980678866538


cat << TRUSTPOLICY > trust-policy-admin-role.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${AWS_ACCOUNT_ID}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
TRUSTPOLICY

aws iam create-role --role-name mock-idbroker-admin-role --assume-role-policy-document file://trust-policy-admin-role.json

aws iam attach-role-policy --role-name mock-idbroker-admin-role --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
```

# Creating the assumer role of IDBroker

Create an assumer policy role and instance profile for IDBroker. IDBroker will use this role to assume the above created role.

```
aws iam create-role --role-name mock-idbroker-assumer --assume-role-policy-document file://trust-policy-assume-role.json

aws iam create-policy --policy-name assume-policy --policy-document file://assume-policy.json

aws iam attach-role-policy --role-name mock-idbroker-assumer --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/assume-policy
```

# Creating the instance profile for IDBroker

IDBroker VM requires an instance profile, this instance profile must be associated with the assumer role.

```
aws iam create-instance-profile --instance-profile-name mock-idbroker-assumer
aws iam add-role-to-instance-profile --instance-profile-name mock-idbroker-assumer --role-name mock-idbroker-assumer
```