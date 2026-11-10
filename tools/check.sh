#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
for file in RivergladesHorde.lua tests/*.lua; do
    luac5.1 -p "$file"
done
luajit tests/riverglades.lua
python3 -m unittest discover -s tests -p 'test_*.py'
