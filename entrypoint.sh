#!/bin/bash

FUNCTIONS_DIR=${FUNCTIONS_DIR:-functions}

cd $FUNCTIONS_DIR; npm install

if [ -z "${FIREBASE_TOKEN}" ]; then
    echo "FIREBASE_TOKEN is missing"
    exit 1
fi

if [ -z "${FIREBASE_PROJECT}" ]; then
    echo "FIREBASE_PROJECT is missing"
    exit 1
fi

if [ -n "${FUNCTIONS_NAME}" ]; then
    IFS=',' read -ra FUNCTIONS <<< "${FUNCTIONS_NAME}"
    FORMATTED_FUNCTIONS=$(printf ",functions:%s" "${FUNCTIONS[@]}")
    FORMATTED_FUNCTIONS=${FORMATTED_FUNCTIONS:1} # Remove leading comma
    firebase deploy \
        -m "${GITHUB_REF} (${GITHUB_SHA})" \
        --project ${FIREBASE_PROJECT} \
        --only ${FORMATTED_FUNCTIONS} \
    exit 0 
fi

firebase deploy \
    -m "${GITHUB_REF} (${GITHUB_SHA})" \
    --project ${FIREBASE_PROJECT} \
    --only functions