all:
	coqc Preloaded.v
	coqc Solution.v
	coqc -I ../src -Q ../theories CW SolutionTest.v

clean:
	rm -f *.o *.cmx *.cmi *.vo *.glob a.out *.ml *.mli