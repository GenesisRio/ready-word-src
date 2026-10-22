#!/bin/bash
set -euo pipefail
# Vercel clones this repo and runs install.sh in that checkout.
# Use the tarball that shipped with the commit.
# A piped install (no local file) downloads from GitHub. REF defaults to main.
if [[ -f src.tgz.b64 ]]; then
  base64 -d < src.tgz.b64 | tar -xz
else
  REF="${REF:-main}"
  curl -fsSL "https://raw.githubusercontent.com/GenesisRio/ready-word-src/${REF}/src.tgz.b64" | base64 -d | tar -xz
fi
npm install
