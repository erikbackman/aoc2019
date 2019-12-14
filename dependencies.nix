{ mkDerivation, base, containers, megaparsec, mtl, split, stdenv
, vector
}:
mkDerivation {
  pname = "aoc2019";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base containers megaparsec mtl split vector
  ];
  executableHaskellDepends = [
    base containers megaparsec split vector
  ];
  license = stdenv.lib.licenses.bsd3;
}
