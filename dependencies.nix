{ mkDerivation, base, containers, megaparsec, split, stdenv, vector
}:
mkDerivation {
  pname = "aoc2019";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base containers megaparsec split vector
  ];
  executableHaskellDepends = [ base ];
  license = stdenv.lib.licenses.bsd3;
}
