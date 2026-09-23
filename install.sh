#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
cat p[0-9][0-9][0-9].b64 | base64 -d | tar -xz
npm install
