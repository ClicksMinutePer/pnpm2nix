{
  description = "A very basic flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      let
        pnpm2nix = (import ./default.nix { inherit pkgs; });
      in
      {
        inherit (pnpm2nix) mkPnpmPackage mkPnpmEnv defaultPnpmOverrides;
      });
}
