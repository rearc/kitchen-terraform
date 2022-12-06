FROM ruby:3-slim AS kitchen-builder
WORKDIR /build
COPY Gemfile /build/Gemfile

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

RUN IFS=$'\n\t' && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get -y --no-install-recommends install \
  git=1:2.3* \
  make=4.* \
  gcc=4:10.2.* \
  g++=4:10.2.*

RUN bundle install

FROM debian:bullseye-slim AS aws-cli-installer

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

RUN IFS=$'\n\t' && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get -y --no-install-recommends install \
  ca-certificates=2021* \
  curl=7.74.* \
  groff=1.22.* \
  less=55* \
  unzip=6.0-2*

RUN IFS=$'\n\t' && \
  ARCH=$(arch) && \
  export ARCH && \
  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" -o "awscliv2.zip" && \
  unzip -q awscliv2.zip && \
  ./aws/install --bin-dir /aws-cli-bin/

# FROM hashicorp/terraform:light AS terraform # No arm64 platform published
# FROM mcr.microsoft.com/azure-cli:${AZURE_CLI_VERSION} AS azure-cli

FROM alpine:3 as terraform
ARG TERRAFORM_VER=1.3.6

SHELL ["/bin/ash", "-euo", "pipefail", "-c"]

RUN ARCH="$(arch)" && \
  case "$ARCH" in aarch64) export ARCH='arm64';; x86_64) export ARCH='amd64';; esac && \
  wget -O - https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_${ARCH}.zip | \
  unzip  -q -d /usr/bin/ - && \
  chmod +x /usr/bin/terraform


FROM ruby:3-slim AS runner
COPY --from=kitchen-builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=kitchen-builder /build/Gemfile /root/Gemfile

COPY --from=terraform /usr/bin/terraform /usr/bin/terraform

COPY --from=aws-cli-installer /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=aws-cli-installer /aws-cli-bin/ /usr/local/bin/

# COPY --from=azure-cli /usr/local/bin /usr/local/bin
# COPY --from=azure-cli /usr/local/lib/python3.10 /usr/local/lib/python3.10


ENV BUNDLE_GEMFILE=/root/Gemfile
SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

RUN IFS=$'\n\t' && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get -y --no-install-recommends install \
  ca-certificates=2021* \
  git=1:2.3* \
  curl=7.74.* \
  groff=1.22.* && \
  apt-get clean autoclean && \
  apt-get autoremove --yes && \
  rm -rf /var/lib/{apt,cache,log}/

WORKDIR /work
VOLUME work

ENTRYPOINT [ "kitchen" ]
