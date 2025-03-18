export JSON_SHA256=$(nix-prefetch-url "https://ziglang.org/download/index.json" ) &&  nix-build compute-hash.nix --show-trace
nix build
