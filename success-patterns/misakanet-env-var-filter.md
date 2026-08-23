---
type: Success Pattern
key: misakanet-env-var-filter
description: "Env var configuration for tool filtering with allowlist/denylist"
tags: [env-var, configuration, filtering, mcp]
created: 2026-08-23
source_url: https://github.com/Ikalus1988/MisakaNet/pull/1228
updated: 2026-08-23
confidence: high
---

# Env Var Configuration: Tool Filtering

## Pattern

Use environment variables for runtime configuration of tool exposure with allowlist/denylist syntax.

## Implementation

```bash
# Allowlist — only expose specific tools
MISAKA_TOOL_FILTER="+search,get_lesson"

# Denylist — hide specific tools
MISAKA_TOOL_FILTER="-write_lesson,preflight"

# Wildcard — pattern matching
MISAKA_TOOL_FILTER="+misakanet_*"
```

## Benefits

- No code changes needed for different deployments
- CI/CD can restrict tools per environment
- Users can customize without modifying config files

## Evidence

- MisakaNet#1228: MERGED, 40 additions, 1 file changed
- Closes issue #1204 (feature request)

## Applicability

MCP servers, API gateways, plugin systems with configurable tool/endpoint exposure.
