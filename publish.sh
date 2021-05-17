#!/usr/bin/env bash

RED='\033[0;31m'
C_RESET='\033[0m'

verifyResult() {
    if [ $1 -ne 0 ]; then
        errln "$2"
    fi
}

errln() {
    echo "❌ $RED Error: $1"
    exit 1
}

set -e
dart --disable-analytics

CREDITIONALS=$1
PACKAGE_PATH=$2

# check for creditionals
if [[ -z $CREDITIONALS ]]; then
    echo "❌ invalid creditionals"
    exit 1
fi

# check if directory exists
if [ ! -d $PACKAGE_PATH ]; then
    errln "❌ specified path: $PACKAGE_PATH does not exist in repo"
fi

# creates directory to store creditionals
if [ ! -d "${HOME}/.pub-cache" ]; then
    mkdir ${HOME}/.pub-cache
fi

echo "📝 Writing credentials"
echo $1 >${HOME}/.pub-cache/credentials.json

echo "🔑 Credentials chechsum"
sha1sum -b ${HOME}/.pub-cache/credentials.json

cd $PACKAGE_PATH

echo "🏃‍♂️ Dry run"
dart pub publish -n
verifyResult $? "while running dry run."

echo "📦 Publishing.."
dart pub publish -f
verifyResult $? "while publishing package."

echo "🚀 Published"
