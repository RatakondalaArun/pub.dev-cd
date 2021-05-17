#!/bin/bash

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

if [ ! $(command -v command) ]; then
    errln "Dart SDK not found. Setup dart sdk using https://github.com/marketplace/actions/setup-dart-sdk"
fi

set -e
dart --disable-analytics

CREDITIONALS=$1
# PACKAGE_PATH=$2

if [[ -z $CREDITIONALS ]]; then
    echo "❌ invalid creditionals"
    exit 1
fi

if [ ! -d "${HOME}/.pub-cache" ]; then
    mkdir ${HOME}/.pub-cache
fi

echo "📝 Writing credentials"
echo $1 >${HOME}/.pub-cache/credentials.json

echo "🔑 Credentials chechsum"
sha1sum -b ${HOME}/.pub-cache/credentials.json

echo "🏃‍♂️ Dry run"
dart pub publish -n
verifyResult $? "while running dry run."

echo "📦 Publishing.."
dart pub publish -f
verifyResult $? "while publish package."

echo "📦 Published 🚀"
