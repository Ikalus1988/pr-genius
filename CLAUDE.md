# PR Genius — Agent Guidelines

## Project Overview

PR Genius is a Python CLI + GitHub Action that provides commit-level improvement
coaching and cross-repo PR pattern intelligence. Published as `prgenius-core` on
PyPI and `ghcr.io/zsxh1990/pr-genius` on GHCR.

## Engineering Skills (auto-invoke)

When the user's task matches one of these patterns, invoke the corresponding
skill **before** writing code. Do not wait for the user to ask.

| Task pattern | Skill to invoke |
|---|---|
| User asks to implement a feature, fix a bug, or describes a change | `/implement` |
| User reports something broken, failing, slow, or says "diagnose" | `/diagnosing-bugs` |
| User asks to review changes, a branch, or a PR | `/review` |
| User wants to build test-first or mentions "red-green-refactor" | `/tdd` |
| User wants to clarify requirements before coding | `/grill-with-docs` |

## Code Standards

- Python 3.9+; no type hints required but recommended for public APIs
- All YAML parsing must strip inline comments before `yaml.safe_load` (lesson: `yaml_inline_comment_coercion.md`)
- Anti-pattern / success-pattern YAML: use block scalar `|` for multiline content
- `anti_patterns_hit` must return object arrays (`{key, description, severity, fix_action}`), never string arrays
- Shell scripts: `set -euo pipefail`; escape user input via temp files, never inline interpolation
- Docker: no shell redirection syntax in COPY/RUN (`2>/dev/null` doesn't work in Dockerfile)

## Testing

```bash
# Quick validation
python3 validate.py

# Full test suite
python3 -m pytest tests/ -v
```

## Release Process

1. Bump version in `pyproject.toml` and `prgenius/__init__.py`
2. Update `CHANGELOG.md`
3. `git tag v1.x.x && git push origin v1.x.x`
4. PyPI publish workflow triggers automatically
5. GHCR publish workflow triggers automatically
6. Major tag `v1` is auto-updated to point to latest release

## Key Files

- `prgenius/src/prgenius/evaluator.py` — core analysis engine
- `prgenius/src/prgenius/cli.py` — CLI entry point
- `github_action/entrypoint.sh` — GitHub Action entry point
- `anti-patterns/` — anti-pattern YAML definitions
- `success-patterns/` — success-pattern YAML definitions
- `docs/` — knowledge bundle shipped with Docker image

## Repository Conventions

- Issue tracker: GitHub Issues (`gh` CLI)
- PRs as a triage surface: no
- Triage labels: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`
- Domain docs: single-context (`CONTEXT.md` at root if exists, `docs/` for knowledge bundle)
