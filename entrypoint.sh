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

/app/kestra "$2" validate "$1" $location $apiToken $tenant