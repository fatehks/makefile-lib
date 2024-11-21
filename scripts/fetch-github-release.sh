#!/usr/bin/env bash

# Updated: <2024-11-21 11:46:06 david.hisel>

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/tools.sh || exit 1

OWNER="$1"
REPO="$2"
ASSET_NAME="$3"

VERSION_URL=$(${CURL} -sL -o /dev/null -w %{url_effective} https://github.com/${OWNER}/${REPO}/releases/latest)
VERSION=${VERSION_URL##*/}


ASSETJSON="fetch-asset-${ASSET_NAME}.json"
${CURL} -sL "https://api.github.com/repos/${OWNER}/${REPO}/releases/latest" \
	-o "$ASSETJSON" \
	-H "Accept: application/vnd.github+json" \
	-H "X-GitHub-Api-Version: 2022-11-28"


DEFAULT_URL="https://github.com/${OWNER}/${REPO}/releases/download/${VERSION}/${ASSET_NAME}"
BROWSER_DOWNLOAD_URL=$(${JQ} -er '.assets[]|select(.name=="'${ASSET_NAME}'")|.browser_download_url' "$ASSETJSON" 2>/dev/null)
rm -f "$ASSETJSON"

DOWNLOAD_URL=${BROWSER_DOWNLOAD_URL:-${DEFAULT_URL}}

${CURL} -fsL ${DOWNLOAD_URL} -o "$ASSET_NAME"

[ $? -eq 0 ] && echo "$ASSET_NAME" && exit 0

echo "ERROR: failed to download $ASSET_NAME: $(cat $ASSET_NAME)"
exit 1
