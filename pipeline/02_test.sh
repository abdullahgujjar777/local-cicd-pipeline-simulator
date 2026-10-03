#!/bin/bash

set -e
set -o pipefail

{

echo "02_test Started"

/home/abdullah_gujjar/Desktop/ci-pipeline/.venv/bin/python3 -m pytest tests/

echo "02_test Ended"

}  2>&1 | tee logs/02_test.log
