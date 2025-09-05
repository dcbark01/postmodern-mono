#!/usr/bin/env just --justfile

alias s := sync
alias f := format
alias l := lint
alias c := check
alias d := deps
alias t := test
alias pc := precommit

set dotenv-load := true

# OPENAI_API_KEY := `echo $OPENAI_API_KEY`  # require api key to be set in environment

# List available recipes
default:
  @just --list

# Install/sync
sync:
  uv sync --all-packages
  direnv allow

# Run formatter
format:
  uv run ruff format

# Run linter
lint:
  uv run ruff check --fix

# Type checking
check:
  uv run ty check

# Check dependencies
deps:
  uv run fawltydeps

# Run tests (for individual package: uv run --package foo pytest)
test:
  uv run pytest -v --cov=apps --cov=libs --cov-report=html --cov-report=term

# Run format/lint/check
precommit:
  just sync
  just format
  just lint
  just check
  just deps
  just test

# Start Jupyter Lab server
jupyter-lab:
  @uv run ipython kernel install --user --env VIRTUAL_ENV {{ justfile_directory() }}/.venv --name=foo
  @uv run jupyter lab --config=./nb/nb_config.py

# Remove cached files
clean *args:
  uv run pyclean . \
    --debris cache coverage package pytest ruff \
    --yes \
    -e python-version.env \
    -e repo-version.env \
    {{ args }}
  uv cache prune
