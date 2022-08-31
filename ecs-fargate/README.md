
## Create a registry

```
aws ecr create-repository --repository-name ecs-flask-sample/home-app
```

Login AWS Register: https://docs.aws.amazon.com/AmazonECR/latest/userguide/registry_auth.html

```
aws ecr get-login-password  --region ap-southeast-1 | docker login --username AWS --password-stdin 952458421842.dkr.ecr.ap-southeast-1.amazonaws.com
```

## Tagging

```
docker tag bogo-home-image:latest 952458421842.dkr.ecr.ap-southeast-1.amazonaws.com/ecs-flask-sample/home-app:latest
```

## Push the image

```
docker push 952458421842.dkr.ecr.ap-southeast-1.amazonaws.com/ecs-flask-sample/home-app
```