# gh-actions-practice

- Practice Github Action
- Practice Terraform on AWS


## Build image

```
docker build . -t vanduc1102/node-web-app

```

## Create a registry

```
aws ecr create-repository --repository-name nodejs-koa-app/hello-app
```

Login AWS Register: https://docs.aws.amazon.com/AmazonECR/latest/userguide/registry_auth.html

```
aws ecr get-login-password  --region ap-southeast-1 | docker login --username AWS --password-stdin 952458421842.dkr.ecr.ap-southeast-1.amazonaws.com
```

## Tagging

```
docker tag vanduc1102/node-web-app:latest 952458421842.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-koa-app/hello-app:latest
```

## Push the image

```
docker push 952458421842.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-koa-app/hello-app:latest
```

# Step 2: Installing Terraform and setup our s3 buckets for terraform states

```
aws s3api create-bucket --bucket wize-space-terraform-backend-store --region ap-southeast-1 --create-bucket-configuration LocationConstraint=ap-southeast-1
```

```
aws s3api put-bucket-encryption --bucket wize-space-terraform-backend-store --server-side-encryption-configuration "{\"Rules\":[{\"ApplyServerSideEncryptionByDefault\":{\"SSEAlgorithm\":\"AES256\"}}]}"
```

```
aws iam create-user --user-name wize-space-terraform-user
```

## Add terraform user policy

```
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --user-name wize-space-terraform-user
```

## Add terraform user policy

```
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess --user-name wize-space-terraform-user
```


## Update policy

- Get AccountId
```
aws iam get-user --user-name  wize-space-terraform-user
```

```
aws s3api put-bucket-policy --bucket wize-space-terraform-backend-store --policy file://wize-space-terraform-backend-store.policy.json
```

```
aws s3api put-bucket-versioning --bucket wize-space-terraform-backend-store --versioning-configuration Status=Enabled
```

