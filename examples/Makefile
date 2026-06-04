coq: Makefile.coq
	$(MAKE) -f Makefile.coq

clean:
	if [ -e Makefile.coq ] ; then $(MAKE) -f Makefile.coq cleanall ; fi
	rm -f Makefile.coq Makefile.coq.conf

Makefile.coq: Makefile _CoqProject
	$(shell if command -v $(COQBIN)coq_makefile >/dev/null 2>&1; then echo '$(COQBIN)coq_makefile'; else echo '$(COQBIN)rocq makefile'; fi) -f _CoqProject -o Makefile.coq
