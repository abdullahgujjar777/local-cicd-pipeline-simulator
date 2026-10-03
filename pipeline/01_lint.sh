#!/bin/bash
set -e
set -o pipefail

{

echo "01_lint Started"

/home/abdullah_gujjar/Desktop/ci-pipeline/.venv/bin/flake8 app/main.py

echo "01_lint Ended"

} 2>&1 | tee logs/01_lint.log
