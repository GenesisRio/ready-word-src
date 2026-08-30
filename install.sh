#!/bin/bash
set -euo pipefail
{
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p00.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p01.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p02.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p03.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p04.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p05.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p06.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p07.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p08.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p09.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p10_0.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p10_1.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p10_2.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p10_3.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p11_0.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p11_1.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p11_2.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p11_3.b64
  curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/p12.b64
} | base64 -d | tar -xz
npm install
