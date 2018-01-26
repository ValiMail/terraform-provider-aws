#!/bin/bash
REV=$(git rev-parse HEAD | cut -c1-6)
DEST="${GOPATH}/bin/darwin_amd64"

BUILD_DATE=$(date -u +%Y-%m-%dT%H:%M:%S%z)
BUILD_FLAGS="-X main.Version=${REV} -X main.BuildDate='${BUILD_DATE}'"

#
# We follow the naming convention at https://www.terraform.io/docs/configuration/providers.html#third-party-plugins,
# appending a '_valimail.#' string in github as part of the version tag for clarity
#
cd "${GOPATH}/${SRC_ROOT}"
mkdir -p "${DEST}"

GOOS=darwin GOARCH=amd64 go build -o "${DEST}/terraform-provider-aws_${CIRCLE_TAG}" terraform-provider-aws/main.go
gzip "${DEST}/terraform-provider-aws_${CIRCLE_TAG}"

