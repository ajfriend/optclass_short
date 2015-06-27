.DEFAULT_GOAL := all

.PHONY: all
all: convex.pdf intro-opt.pdf

PANDOC := pandoc
PANDOC_FLAGS := -t beamer
PANDOC_FLAGS += -V classoption="aspectratio=169"
PANDOC_FLAGS += -H formatting.tex
PANDOC_FLAGS += -H talk_defs.tex
PANDOC_FLAGS += --slide-level 2
PANDOC_FLAGS += -s
PANDOC_DEPS := formatting.tex talk_defs.tex

# pattern rule to generate pdf from markdown
%.pdf: %.md $(PANDOC_DEPS)
	$(PANDOC) $(PANDOC_FLAGS) $< -o $@

# pattern rule to generate tex from markdown
%.tex: %.md $(PANDOC_DEPS)
	$(PANDOC) $(PANDOC_FLAGS) $< -o $@

# targets for graph sequence pdfs

## intro-opt.pdf depends on graph sequence
intro-opt.pdf: graph-sequence

## split the graph-sequence.pdf
.PHONY: graph-sequence
graph-sequence:
	pdfseparate intro-opt-fig/graph-sequence.pdf intro-opt-fig/graph-sequence-%d.pdf 

## clean up split pdfs
.PHONY: clean-graph-sequence
clean-graph-sequence:
	$(RM) intro-opt-fig/graph-sequence-*.pdf

.PHONY: clean
clean:
	$(RM) convex.pdf
	$(RM) convex.tex
	$(RM) intro-opt.pdf
	$(RM) intro-opt.tex	
