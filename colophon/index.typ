#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [colophon])
#metadata((title: "colophon", translation_key: "colophon")) <website-metadata>

#m.logo("colophon")

#title()

#m.side-by-side(
  m.screenshot("/packages/colophon/readme-assets/manuscript.png", caption: [A short manuscript, compiled normally]),
  m.screenshot("/packages/colophon/readme-assets/audit.png", caption: [The generated audit.pdf]),
)

*colophon* audits your manuscript _as actually composed_ — word count
(total and per section), reading time, page count, a figure/table
inventory, labels never referenced, bibliography entries never cited —
in a companion PDF, produced from the same compile as the manuscript
itself. Unlike its sibling packages, it needs no per-passage markup: no
`check()`, no `passage()` — an auditor, not an annotator.

= The problem

"How many words is this?", "does this figure have a caption?", "did I
ever reference that equation I labelled?" — a word count taken from
source text is wrong the moment a citation resolves into a bracketed
number, and a page count doesn't exist at all until the document has
actually been laid out. `colophon` audits the same, real compile that
produces the manuscript, not a stale copy.

= Key features

- *Word count, total and by section*, with citation/reference machinery already stripped out.
- *Works through `palimpsest`'s own marks* — reads their metadata directly, so the count matches exactly what the _clean_, submitted manuscript shows.
- *An abstract, counted on its own* — `abstract(body)`, an invisible marker placed once wherever you already write your abstract.
- *A figure/table inventory with the real numbering* — via `ref(...)`, correct even for a template with its own exotic numbering scheme.
- *Labels never referenced, and bibliography entries never cited.*
- *Reports facts, never enforces them* — no per-journal limits, no `strict` diagnostics: an orphan label is often deliberate.

= Installation

```typ
#import "@preview/colophon:0.1.0": *
#import "@preview/contexture:0.1.0": bundle
```

Requires Typst 0.15 or later, specifically its `--features bundle`
export (still experimental).

= Full manual

The complete, progressive manual — a first audit, word counts, the
abstract, the figure/table inventory, orphan labels and uncited
references, wiring a real project, and colophon in the contexture
ecosystem — starts at
#link(calepin.url("/colophon/quickstart/"))[Quickstart: your first audit].

= Examples

Two complete, working projects — the same full-length fake articles
`palimpsest` uses for its own examples, with `colophon` added alongside
its reviewer letter — live in the repository:
#link("https://github.com/eusebe/typst-colophon/tree/main/examples")[examples/]
(#link("https://github.com/eusebe/typst-colophon")[repository]).

= Combining with other packages

`colophon`'s `report(...)` combines cleanly with
#link(calepin.url("/palimpsest/"))[palimpsest]'s `letter(...)` and
#link(calepin.url("/checkitoff/"))[checkitoff]'s `checklist(...)` in the same compile. See
#link(calepin.url("/combining/"))[Combining packages].
