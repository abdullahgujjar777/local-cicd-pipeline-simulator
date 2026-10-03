#!/bin/bash

set -e
set -o pipefail

{
echo "03_build Started"

timestamp=$(date +"%Y%m%d_%H%M%S")

filename="build_${timestamp}.tar.gz"

tar -czf "builds/$filename" app/

echo "03_build Ended"

} 2>&1 | tee logs/03_build.log
