#!/usr/bin/env bash
# Builds the site into ./dist using Typst's experimental bundle export.
#
# Usage:
#   ./build.sh            # one-off build
#   ./build.sh --watch    # live-reloading dev server (http://localhost:3000)
set -euo pipefail

cd "$(dirname "$0")"

if [ "${1:-}" = "--watch" ]; then
  TYPST_FEATURES=bundle,html typst watch --format bundle main.typ dist
else
  rm -rf dist
  TYPST_FEATURES=bundle,html typst compile --format bundle main.typ dist
  echo "Built site into ./dist"
fi
