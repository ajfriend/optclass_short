convex.pdf: convex.md
	pandoc -t beamer -H formatting.tex -H talk_defs.tex --slide-level 2 -s convex.md -o convex.pdf