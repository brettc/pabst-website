# PABST (and BAM!) website tasks

# List available recipes
help:
  just --list

# Live-reloading preview server
preview:
  quarto preview

# Build the static site into _site/
render:
  quarto render

# Open the built site in a browser
browse:
  open _site/index.html

# Verify the Quarto install
check:
  quarto check

# Remove build artifacts
clean:
  rm -rf _site .quarto

# Scaffold a new year by cloning an existing one. Usage: just new-year 2027 [2026]
new-year YEAR FROM="2026":
  #!/usr/bin/env bash
  set -euo pipefail
  if [ -e "{{YEAR}}" ]; then
    echo "{{YEAR}}/ already exists" >&2
    exit 1
  fi
  if [ ! -d "{{FROM}}" ]; then
    echo "source year {{FROM}}/ not found" >&2
    exit 1
  fi
  cp -R "{{FROM}}" "{{YEAR}}"
  echo "Created {{YEAR}}/ from {{FROM}}/."
  echo "Next: edit {{YEAR}}/*.qmd and add a navbar dropdown in _quarto.yml."
