#!/bin/sh
set -e

export OPENID_ENDPOINT=https://login.microsoftonline.com/${TENANT_ID}/v2.0/.well-known/openid-configuration
export TOKEN_ENDPOINT=https://login.microsoftonline.com/${TENANT_ID}/oauth2/token


# Prepend "oauth.sh" if the first argument is not an executable
if ! type -- "$1" &> /dev/null; then
	set -- /usr/local/bin/oauth.sh --operation "$@"
fi

exec "$@"
