let
  pkgs = import <nixpkgs> { };

in
  pkgs.haskellPackages.callPackage ./dependencies.nix { }
