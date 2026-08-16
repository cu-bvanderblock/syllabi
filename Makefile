# Render Markdown syllabi to PDF / DOCX with pandoc.
# Markdown is the source of truth; outputs are regenerated (and gitignored).

SOURCES := $(wildcard */*.md)
PDFS    := $(SOURCES:.md=.pdf)
DOCXS   := $(SOURCES:.md=.docx)

PANDOC        ?= pandoc
PANDOC_FLAGS  := --from=gfm --standalone
PDF_ENGINE    ?= typst

.PHONY: all pdf docx clean check

all: pdf

pdf: $(PDFS)
docx: $(DOCXS)

%.pdf: %.md
	$(PANDOC) $(PANDOC_FLAGS) --resource-path=$(dir $<) --pdf-engine=$(PDF_ENGINE) -o $@ $<

%.docx: %.md
	$(PANDOC) $(PANDOC_FLAGS) --resource-path=$(dir $<) -o $@ $<

# Fail early with a helpful message if pandoc is missing.
check:
	@command -v $(PANDOC) >/dev/null 2>&1 || { \
		echo "pandoc not found. Install with: brew install pandoc"; \
		exit 1; }
	@command -v $(PDF_ENGINE) >/dev/null 2>&1 || { \
		echo "PDF engine '$(PDF_ENGINE)' not found. Install with: brew install typst"; \
		echo "(or set PDF_ENGINE=xelatex etc. if you prefer a LaTeX engine)"; \
		exit 1; }
	@echo "pandoc:  $$($(PANDOC) --version | head -1)"
	@echo "engine:  $(PDF_ENGINE) $$($(PDF_ENGINE) --version 2>/dev/null | head -1)"

clean:
	rm -f $(PDFS) $(DOCXS)
