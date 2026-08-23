---
type: Success Pattern
key: misakanet-windows-temp-file
description: "Cross-platform fix uses temp file instead of CLI args for large payloads"
tags: [cross-platform, windows, temp-file, cli-args]
created: 2026-08-23
source_url: https://github.com/Ikalus1988/MisakaNet/pull/1214
updated: 2026-08-23
confidence: high
---

# Cross-Platform: Temp File for Large Payloads

## Pattern

When passing large JSON payloads to child processes on Windows, use temp files with environment variables instead of CLI arguments.

## Problem

Windows command-line parsing mangles JSON payloads with special characters (quotes, backslashes). CLI arg length limits (8191 chars) can silently truncate data.

## Solution

1. Write payload to temp file (`os.tmpdir()`)
2. Pass file path via environment variable (`FATAL_PAYLOAD_FILE`)
3. Handler reads from file, falls back to env var for small payloads

## Evidence

- MisakaNet#1214: Windows CI test failure → temp file fix → cherry-picked by maintainer
- Maintainer: "Temp file approach is more robust than CLI arg passing"

## Applicability

Any cross-platform tool that spawns child processes with structured data payloads.
