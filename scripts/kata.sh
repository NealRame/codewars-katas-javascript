#! /usr/bin/env bash

# stop script with non-zero exit code if anything go wrong
set -e

# stop script with non-zero exit code when trying to reference an undefined
# variable
set -u

# If any command in a pipeline fails, that return code will be used as the
# return code of the whole pipeline
set -o pipefail

SOURCES_DIR="${SOURCES_DIR:-$PWD}"
KATA_NAME="${1// }"

KATAS_SOURCE_DIR="$SOURCES_DIR/katas"
KATAS_TESTS_DIR="$SOURCES_DIR/tests"

KATA_SOURCE_JS="$KATAS_SOURCE_DIR/${KATA_NAME}.js"
mkdir -p "$KATAS_SOURCE_DIR"
[ -f "$KATA_SOURCE_JS" ] || touch "$KATA_SOURCE_JS"

KATA_TESTS_JS="$KATAS_TESTS_DIR/${KATA_NAME}_spec.js"
mkdir -p "$KATAS_TESTS_DIR"
[ -f "$KATA_TESTS_JS" ] || cat > "$KATA_TESTS_JS" <<EOF
const assert = require('assert')
const kata = require('${KATA_NAME}')
describe('Your Kata test description here', () => {
})
EOF