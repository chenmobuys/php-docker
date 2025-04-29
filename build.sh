#!/bin/bash

IMAGE_NAME="chenmobuys/php"
PLATFORMS="linux/amd64,linux/arm64"

if [ "$#" -gt 0 ]; then
    versions=("$@")
else
    versions=(*/)
    versions=("${versions[@]%/}")
fi

for version in "${versions[@]}"; do

    echo "Building $version..."

    cd "$version_dir" || continue

    docker buildx create --use --name multiplatform-builder || true
    docker buildx build --platform ${PLATFORMS} \
        -t ${IMAGE_NAME}:${version} \
        --push .

    cd ..

done
