#!/bin/bash

# Set up auth if required
if [[ $3 ]]; then
  location="--server=$3"
  if [[ $4 && $5 ]]; then
      location="$location --user=$4:$5"
  fi

  # Check if there is a API Token
  apiToken=""
  if [[ ${6} ]]; then
    apiToken="--api-token=${6}"
  fi

  # Check if there is a tenant id
  tenant=""
  if [[ $7 ]]; then
    tenant="--tenant=${7}"
  fi
else
  location="--local"
fi

# Track usage
CONFIG=$(curl -s https://api.kestra.io/v1/config)
PH_TOKEN=$(echo "$CONFIG" | sed -E  's/.*"token":"([^"]+)".*/\1/')
PH_API_HOST=$(echo "$CONFIG" | sed -E  's/.*"apiHost":"([^"]+)".*/\1/')
PH_ID=$(echo "$CONFIG" | sed -E  's/.*"id":"([^"]+)".*/\1/')

curl -s -L -H "Content-Type: application/json" -d '{
    "api_key": "'"$PH_TOKEN"'",
    "event": "Github Actions",
    "distinct_id": "'"$PH_ID"'",
    "properties": {
        "gha": {
            "name": "validate-action",
            "resource": "'"$2"'"
        }
    }
}' "$PH_API_HOST"capture/ > /dev/null

# Run it
/app/kestra "$2" validate "$1" $location $apiToken $tenant
