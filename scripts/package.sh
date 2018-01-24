#!/bin/bash
REV=$(git rev-parse HEAD | cut -c1-6)
DEST="${PKG_ROOT}/darwin_amd64"

mkdir -p "${DEST}"

BUILD_DATE=$(date -u +%Y-%m-%dT%H:%M:%S%z)
BUILD_FLAGS="-X main.Version=${REV} -X main.BuildDate='${BUILD_DATE}'"

#
# We follow the naming convention at https://www.terraform.io/docs/configuration/providers.html,
# appending a '_valimail' string in github as part of the version tag for clarity
#
cd "${GOPATH}/${SRC_ROOT}"
GOOS=darwin GOARCH=amd64 go build -o "${DEST}/terraform-provider-aws_${CIRCLE_TAG}" terraform-provider-aws/main.go

