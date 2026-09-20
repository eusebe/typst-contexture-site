#import "/.calepin/calepin.typ" as calepin

#set document(title: [palimpsest])
#metadata((title: "palimpsest", translation_key: "palimpsest")) <website-metadata>

#title()

*palimpsest* turns one annotated manuscript into everything a
peer-review response needs: the clean manuscript, a tracked-changes
version showing every edit, and a response letter that cites the
manuscript's own real page and figure numbers — automatically, and
always in sync.

You mark changes once, inline, in the manuscript itself. Two
`typst compile` commands then produce all of it.

= The problem

Responding to peer review normally means maintaining four things by
hand: the revised manuscript, a version showing what changed, a letter
citing modified passages and page numbers, and the certainty that no
comment went unanswered. These drift apart the moment a last-minute fix
lands. `palimpsest` makes the second, third, and fourth of those
_derivable_ from the first.

= Key features

- *Mark once, get up to four documents.* `add`, `del`, `rep` inline in your manuscript; two compiles produce the clean and tracked-changes manuscript, plus a clean and tracked response letter.
- *Real cross-references, not copy-pasted page numbers.* `pinpoint(<anchor>)` reports the manuscript's actual, current page.
- *Quote the manuscript verbatim in the letter.* `pinpoint(<anchor>, excerpt: true)` re-emits the real passage.
- *Reviewers, editor, and co-authors, all colored and tracked* automatically, each with their own letter section.
- *Figure/table/equation/heading numbering that survives tracking.*
- *Diagnostics*, promotable to hard compile errors with `strict: true`.

= Installation

```typ
#import "@preview/palimpsest:0.1.0": *
#import "@preview/contexture:0.1.0": bundle
```

Requires Typst 0.15 or later, specifically its `--features bundle`
export (still experimental).

= Full manual

The complete, progressive manual — a first revision round, marking
changes, anchors, styling marks, shortcuts, writing the exchanges,
pinpoint, xref, the change-list, tables, bibliography, diagnostics,
wiring a real project, and palimpsest in the contexture ecosystem —
starts at #link(calepin.url("/palimpsest/quickstart/"))[Your first revision round].
Two full worked examples (real Typst Universe templates, real figures)
live in the
#link("https://github.com/eusebe/typst-palimpsest/tree/main/examples")[repository],
alongside a PDF version
(#link("https://github.com/eusebe/typst-palimpsest/blob/main/docs/manual.pdf")[docs/manual.pdf]).

= Combining with other packages

`palimpsest`'s `letter(...)` is just a description of a document to
build — it combines cleanly with #link(calepin.url("/checkitoff/"))[checkitoff]'s
`checklist(...)` and #link(calepin.url("/colophon/"))[colophon]'s `report(...)` in
the same compile. See #link(calepin.url("/combining/"))[Combining packages].
