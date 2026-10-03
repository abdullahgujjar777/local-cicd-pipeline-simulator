#!/bin/bash

while true; do
    inotifywait -e close_write app/
    echo "Change detected"
    bash run_pipeline.sh
done
