#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

AWS_REGION=${AWS_REGION:-us-east-1}
INSPEC_AWS_ACCESS_KEY_ID=${INSPEC_AWS_ACCESS_KEY_ID:-}
INSPEC_AWS_SECRET_ACCESS_KEY=${INSPEC_AWS_SECRET_ACCESS_KEY:-}
TF_AWS_ACCESS_KEY_ID=${TF_AWS_ACCESS_KEY_ID:-}
TF_AWS_SECRET_ACCESS_KEY=${TF_AWS_SECRET_ACCESS_KEY:-}
TF_AWS_SESSION_TOKEN=${TF_AWS_SESSION_TOKEN:-}
RELEASE=${RELEASE:-test}

docker run --rm -it \
    -v "$PWD":/work \
    -e AWS_ACCESS_KEY="$INSPEC_AWS_ACCESS_KEY_ID" \
    -e AWS_SECRET_KEY="$INSPEC_AWS_SECRET_ACCESS_KEY" \
    -e AWS_REGION="$AWS_REGION" \
    -e TF_VAR_access_key="$TF_AWS_ACCESS_KEY_ID" \
    -e TF_VAR_secret_key="$TF_AWS_SECRET_ACCESS_KEY" \
    -e TF_VAR_token="$TF_AWS_SESSION_TOKEN" \
    -e TF_VAR_region="$AWS_REGION" \
    kitchen-terraform:"${RELEASE}" "$@"
    # --entrypoint /bin/bash kitchen-terraform:"${RELEASE}"
