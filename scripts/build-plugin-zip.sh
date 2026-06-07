#!/usr/bin/env bash
# Rebuild the distributable plugin archive from the secondbrain/ plugin source.
#
# Produces dist/secondbrain-plugin.zip — a "zip of the plugin directory" that
# Claude Code / Cowork load with:  claude --plugin-dir dist/secondbrain-plugin.zip
# (or, hosted, via --plugin-url). The archive includes the token-less .mcp.json.
#
# Run this after editing anything under secondbrain/, then commit the new zip.
#
# Usage: bash scripts/build-plugin-zip.sh
set -euo pipefail
cd "$(dirname "$0")/.."

out="dist/secondbrain-plugin.zip"
mkdir -p dist
rm -f "$out"

# Nested layout: the archive contains a top-level secondbrain/ folder.
zip -r -X "$out" secondbrain -x '*.DS_Store' >/dev/null

echo "Built $out"
unzip -l "$out"
