# Course Syllabi

Version-controlled Markdown source for my course syllabi. Markdown is the
**canonical** version; Google Docs / PDF are downstream renders. Tracking the
syllabi as Markdown gives clean, readable diffs of wording changes from one
semester to the next.

## Layout

```
.
├── busm-3020/
│   └── 3020-syllabus.md   # BUSM 3020: Business & Financial Analytics I
├── busm-3021/
│   └── 3021-syllabus.md   # BUSM 3021: Business & Financial Analytics II (placeholder)
├── Makefile               # render Markdown → PDF / DOCX via pandoc
└── README.md
```

Each syllabus starts with YAML front-matter (course, term, instructor) so
term-to-term diffs stay easy to read.

## Workflow

1. Edit the Markdown (`busm-3020/3020-syllabus.md`).
2. Commit the change: `git commit -am "Update BUSM 3020 for <term>"`.
3. Render for distribution: `make busm-3020/3020-syllabus.pdf` (see below).
4. Optionally tag the semester's release: `git tag fa26 && git push --tags`.

## Rendering (pandoc)

Rendered outputs (`*.pdf`, `*.docx`) are **not** committed; they are
regenerated from the Markdown. Requires pandoc, plus a PDF engine
([typst](https://typst.app), a lightweight single binary):

```bash
brew install pandoc typst
```

Then:

```bash
make check   # verify pandoc + PDF engine are installed
make pdf     # render every syllabus to PDF
make docx    # render every syllabus to DOCX
make clean   # remove rendered outputs
```

Prefer a LaTeX look instead? Install a LaTeX engine and override the engine:
`make pdf PDF_ENGINE=xelatex`.

## Semester tags

Each semester's final syllabus is tagged (e.g. `fa26`, `sp27`) so any past
term's exact wording can be recovered with `git checkout <tag>`.
