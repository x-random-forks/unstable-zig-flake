#!/usr/bin/env bash

set -e  # Exit on error

export JSON_SHA256=$(nix-prefetch-url "https://ziglang.org/download/index.json")

FILE="$(nix-build compute-hash.nix --show-trace | tail -n 1)"
echo "$FILE"
cp "$FILE" "zig-lock.json"

nix build
