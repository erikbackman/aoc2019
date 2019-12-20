let
  pkgs = import <nixpkgs> { };
  tools = with pkgs; [
    ghc
    haskellPackages.ghcid
    haskellPackages.hasktags
    cabal2nix
    cabal-install
  ];
in
  pkgs.mkShell {
   buildInputs = tools;
  }
