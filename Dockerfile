ARG STEP_1_IMAGE=alpine:3.12
ARG IMAGE_TAG=0.0.0

FROM ${STEP_1_IMAGE}

# ARG TENANT_ID=123

LABEL Name="danielscholl/alpine-oauth" \
  Version=${IMAGE_TAG}

ENV TENANT_ID=${TENANT_ID} \
  CLIENT_ID=${CLIENT_ID} \
  CLIENT_SECRET=${CLIENT_SECRET}


ENV BUILD_PACKAGES \
  bash \
  curl \
  jq \
  netcat-openbsd

RUN set -x \
  && apk update \
  && apk upgrade \
  && apk add --no-cache ${BUILD_PACKAGES} \
  && rm -rf /var/cache/apk/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
COPY oauth.sh /usr/local/bin/oauth.sh
RUN chmod +x /usr/local/bin/oauth.sh

# Create  User
RUN addgroup -S oauth && adduser -S oauth -G oauth

USER oauth
WORKDIR /home/oauth


ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["oauth"]
