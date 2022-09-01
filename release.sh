#!/bin/bash
EKS_HOST=149671120510.dkr.ecr.ap-northeast-1.amazonaws.com
tag=$(echo -n "$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)" | sed "s#/#-#g")
image_name="$EKS_HOST"/ethereum-etl:"$tag"

echo "$image_name"

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin "$EKS_HOST"
docker buildx build --push -t "$image_name" .