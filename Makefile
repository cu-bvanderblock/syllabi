# Render Markdown syllabi to PDF / DOCX with pandoc.
# Markdown is the source of truth; outputs are regenerated (and gitignored).

SOURCES := $(wildcard */syllabus.md)
PDFS    := $(SOURCES:.md=.pdf)
DOCXS   := $(SOURCES:.md=.docx)

PANDOC        ?= pandoc
PANDOC_FLAGS  := --from=gfm --standalone
PDF_ENGINE    ?= pdflatex

.PHONY: all pdf docx clean check

all: pdf

pdf: $(PDFS)
docx: $(DOCXS)

%.pdf: %.md
	$(PANDOC) $(PANDOC_FLAGS) --pdf-engine=$(PDF_ENGINE) -o $@ $<

%.docx: %.md
	$(PANDOC) $(PANDOC_FLAGS) -o $@ $<

# Fail early with a helpful message if pandoc is missing.
check:
	@command -v $(PANDOC) >/dev/null 2>&1 || { \
		echo "pandoc not found. Install with: brew install pandoc"; \
		echo "For PDF output also install a LaTeX engine, e.g.: brew install --cask basictex"; \
		exit 1; }
	@echo "pandoc: $$($(PANDOC) --version | head -1)"

clean:
	rm -f $(PDFS) $(DOCXS)
