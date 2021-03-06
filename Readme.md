## Alpine OAUTH Base Image

![Docker Build and Push](https://github.com/danielscholl/alpine-oauth/workflows/Docker%20Build%20and%20Push/badge.svg)

This is a repository for an OAuth2 wrapper container.


Build
------

The make script will build the docker image.

__COMMAND__
```bash
$ make \
    STEP_1_IMAGE="alpine:3.12" \
    docker-build
```

Execute
------
Create an environment file and execute OAuth Operations

```bash
TENANT_ID=<your_tenant_id>
CLIENT_ID=<your_client_id>
CLIENT_SECRET=<your_client_secret>

cat > osdu_azure_custom_values.yaml << EOF
# This file contains the essential configs for the osdu on azure helm chart

TENANT_ID=$TENANT_ID
CLIENT_ID=$CLIENT_ID
CLIENT_SECRET=$CLIENT_SECRET

EOF

docker run --env-file .env danielscholl/alpine-oauth:latest get_oidc_server_infos
docker run --env-file .env danielscholl/alpine-oauth:latest client_credentials
```
