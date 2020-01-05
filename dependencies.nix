{ mkDerivation, base, containers, free, lens, megaparsec, mtl
, split, stdenv, transformers, vector
}:
mkDerivation {
  pname = "aoc2019";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base containers free lens megaparsec mtl split transformers vector
  ];
  executableHaskellDepends = [
    base containers free lens megaparsec mtl split transformers vector
  ];
  license = stdenv.lib.licenses.bsd3;
}
