#!/bin/bash

set -e
set -o pipefail

{
echo "04_deploy Started"

if [ -z "$(ls -A builds/*.tar.gz 2>/dev/null)" ]; then
    echo "ERROR: No build archive found!"
    exit 1
fi

latest=$(ls -t builds/*.tar.gz | head -1)

rm -rf prod/*

tar -xzf "$latest" -C prod/

python3 prod/app/main.py

echo "Deployed $latest at $(date)"

echo "04_deploy Ended"
} 2>&1 | tee logs/04_deploy.log
