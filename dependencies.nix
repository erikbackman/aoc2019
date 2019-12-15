{ mkDerivation, base, containers, lens, megaparsec, mtl, split
, stdenv, transformers, vector
}:
mkDerivation {
  pname = "aoc2019";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base containers lens megaparsec mtl split transformers vector
  ];
  executableHaskellDepends = [
    base containers lens megaparsec mtl split vector
  ];
  license = stdenv.lib.licenses.bsd3;
}
