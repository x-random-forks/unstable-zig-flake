{
  description = "flake for the unstable version of Zig";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system: 
      let 
        pkgs = import nixpkgs { inherit system; };
        zigLock = builtins.fromJSON (builtins.readFile ./zig-lock.json);
        zigURL = ZigLock.${system}.tarball;
        zigSha256 = zigLock.${system}.shasum;

        zig-unstable = pkgs.stdenv.mkDerivation {
          pname = "zig-unstable";
          version = "unstable";
          src = pkgs.fetchTarball {
            url = zigURL;
            sha256 = zigSha256;
          };
          installPhase = ''
            mkdir -p $out/bin
            cp -r zig*/* $out/bin/
          '';
        };
      in {
        packages.default = zig-unstable;
      }
    );
}
