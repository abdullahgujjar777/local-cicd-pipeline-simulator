#!/bin/bash


pipeline_start=$(date +%s)

stages=("Lint" "Test" "Build" "Deploy")
results=()


SECONDS=0
bash pipeline/01_lint.sh
status=$?
if [ $status -ne 0 ]; then
    echo "Pipeline failed at: Lint"
    results+=("Failed")
else
    results+=("Passed")
fi
echo "Time taken: $SECONDS seconds"



if [ $status -eq 0 ]; then
    SECONDS=0
    bash pipeline/02_test.sh
    status=$?
    if [ $status -ne 0 ]; then
        echo "Pipeline failed at: Test"
        results+=("Failed")
    else
        results+=("Passed")
    fi
    echo "Time taken: $SECONDS seconds"
else
    results+=("Skipped")
fi


if [ $status -eq 0 ]; then
    SECONDS=0
    bash pipeline/03_build.sh
    status=$?
    if [ $status -ne 0 ]; then
        echo "Pipeline failed at: Build"
        results+=("Failed")
    else
        results+=("Passed")
    fi
    echo "Time taken: $SECONDS seconds"
else
    results+=("Skipped")
fi



if [ $status -eq 0 ]; then
    SECONDS=0
    bash pipeline/04_deploy.sh
    status=$?
    if [ $status -ne 0 ]; then
        echo "Pipeline failed at: Deploy"
        results+=("Failed")
    else
        results+=("Passed")
    fi
    echo "Time taken: $SECONDS seconds"
else
    results+=("Skipped")
fi



echo "- -"
if [ $status -eq 0 ]; then
    echo "Deployment successful"
fi
echo "Summary"
echo "Total pipeline time: $(($(date +%s) - pipeline_start)) seconds"
current_time=$(date)
echo "$current_time"
for i in "${!stages[@]}"; do
    echo "  ${stages[$i]} → ${results[$i]}"
done
