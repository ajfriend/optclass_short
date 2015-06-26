.DEFAULT_GOAL := all

.PHONY: all
all: convex.pdf optimization-intro.pdf

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

.PHONY: clean
clean:
	$(RM) convex.pdf
	$(RM) optimization-intro.pdf
	$(RM) convex.tex
	$(RM) optimization-intro.tex	
