#!/bin/bash
set -euo pipefail
# Vercel install command passes REF for a branch deploy. Default is main.
REF="${REF:-main}"
curl -fsSL "https://raw.githubusercontent.com/GenesisRio/ready-word-src/${REF}/src.tgz.b64" | base64 -d | tar -xz
npm install
