OPTIMIZATION=-O0

build: 
	nix-shell --run "cabal new-build all -j --ghc-options $(OPTIMIZATION)"

DAY=""
run:
	nix-shell --run "cabal new-exec -- aoc2019 $(DAY)"

install:
	nix-shell --run "cabal new-install -j --ghc-options $(OPTIMIZATION) --overwrite-policy=always"

ghcid: clean 
	nix-shell --run "ghcid -s \"import Main\" -c \"cabal new-repl\""

ghci:
	nix-shell --run "cabal new-repl"

etags:
	nix-shell --run "hasktags  -e ./src"

update-cabal:
	nix-shell --run "cabal2nix ./ > dependencies.nix"

enter:
	nix-shell --cores 0 -j 8 --pure

RUN=""
run-in-shell:
	nix-shell --cores 0 -j 8 --run "$(RUN)"

clean: 
	rm -fR dist dist-*
