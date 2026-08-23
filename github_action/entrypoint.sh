#!/bin/bash
set -e

# PR Genius GitHub Action Entry Point
# Supports both direct command and action inputs

# If args are provided, use them directly (for docker:// usage)
if [ $# -gt 0 ]; then
    exec python3 -m prgenius "$@"
fi

# Otherwise, use action inputs
if [ -z "$INPUT_TITLE" ]; then
    echo "Error: title input is required"
    exit 1
fi

if [ -z "$INPUT_REPO" ]; then
    echo "Error: repo input is required"
    exit 1
fi

# Build command
CMD="python3 -m prgenius ${INPUT_COMMAND:-coach}"

# Add title
CMD="$CMD \"${INPUT_TITLE}\""

# Add required repo
CMD="$CMD --repo ${INPUT_REPO}"

# Add optional parameters
if [ -n "$INPUT_BODY" ]; then
    # Write body to temp file to avoid shell escaping issues
    echo "$INPUT_BODY" > /tmp/pr_body.txt
    CMD="$CMD --body \"$(cat /tmp/pr_body.txt)\""
fi

if [ -n "$INPUT_DESCRIPTION" ]; then
    CMD="$CMD --description \"${INPUT_DESCRIPTION}\""
fi

if [ -n "$INPUT_FORMAT" ]; then
    CMD="$CMD --format ${INPUT_FORMAT}"
fi

if [ -n "$INPUT_DIFF_STAT" ]; then
    CMD="$CMD --diff-stat \"${INPUT_DIFF_STAT}\""
fi

if [ -n "$INPUT_AUTHOR" ]; then
    CMD="$CMD --author ${INPUT_AUTHOR}"
fi

if [ -n "$INPUT_STAR_COUNT" ]; then
    CMD="$CMD --star-count ${INPUT_STAR_COUNT}"
fi

if [ -n "$INPUT_REPO_MERGE_RATE" ]; then
    CMD="$CMD --repo-merge-rate ${INPUT_REPO_MERGE_RATE}"
fi

# Execute command
echo "Running: $CMD"
eval "$CMD"
