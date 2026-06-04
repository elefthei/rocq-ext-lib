all: theories examples

COQDOCJS_LN?=true
-include coqdocjs/Makefile.doc
COQMAKEFILE?=Makefile.coq

# Rocq 9.1 renamed `coq_makefile` to `rocq makefile`. Prefer the legacy
# binary when present, otherwise fall back to the new subcommand.
COQ_MAKEFILE?=$(shell if command -v $(COQBIN)coq_makefile >/dev/null 2>&1; then echo '$(COQBIN)coq_makefile'; else echo '$(COQBIN)rocq makefile'; fi)

theories: $(COQMAKEFILE)
	$(MAKE) -f $(COQMAKEFILE)

$(COQMAKEFILE):
	$(COQ_MAKEFILE) -f _CoqProject -o $(COQMAKEFILE)

install: $(COQMAKEFILE)
	$(MAKE) -f $(COQMAKEFILE) install

examples: theories
	$(MAKE) -C examples

clean:
	if [ -e $(COQMAKEFILE) ] ; then $(MAKE) -f $(COQMAKEFILE) cleanall ; fi
	$(MAKE) -C examples clean
	@rm -f $(COQMAKEFILE) $(COQMAKEFILE).conf

uninstall:
	$(MAKE) -f $(COQMAKEFILE) uninstall

dist:
	@ git archive --prefix rocq-ext-lib/ HEAD -o $(PROJECT_NAME).tgz

.PHONY: all clean dist theories examples html

TEMPLATES ?= ../templates

resources/index.html: resources/index.md
	pandoc -s $^ -o $@

resources/index.md: meta.yml $(TEMPLATES)/index.md.mustache
	$(TEMPLATES)/generate.sh $@

publish%:
	opam publish --packages-directory=released/packages \
		--repo=rocq-prover/opam --tag=v$* -v $* rocq-community/rocq-ext-lib
