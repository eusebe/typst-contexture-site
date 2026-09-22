#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [checkitoff])
#metadata((title: "checkitoff", translation_key: "checkitoff")) <website-metadata>

#m.logo("checkitoff")

#title()

*checkitoff* fills in a reporting-guideline checklist — CONSORT, PRISMA,
SPIRIT, STARD, STROBE — automatically. Mark where each item is
answered in your manuscript; one compile produces the clean manuscript
plus a completed grid citing the _real_ page each item landed on.

= The problem

A completed reporting-guideline grid is, today, filled in by hand —
and it's wrong the moment a paragraph moves a page. This works with
real page numbers because a single compile can produce the manuscript
and the grid together, sharing one introspection space.

= Key features

- *Mark once, get both documents.* `check(id, body)` anchors `body` to item `id` — zero visual footprint in the real manuscript.
- *A point-marker form* for text already rendered by something else (`check(id)`, no body) — for the one case a revision-tracking package like `palimpsest` already renders the text.
- *`na(id, reason: ...)`* declares an item not applicable, with a justification.
- *Seven checklists, built in* — CONSORT 2025, PRISMA 2020, SPIRIT 2025, STARD 2015, STROBE (×3 study designs) — each transcribed from its official source.
- *A drafting overlay* (`--input preview=true`) highlights every checked span, never present in the real, submitted manuscript.
- *Quote the real wording* with `excerpt-of(id, quotes: true)`.
- *Diagnostics*, promotable to hard compile errors with `strict: true`.

= Installation

```typ
#import "@preview/checkitoff:0.1.0": *
#import "@preview/contexture:0.1.0": bundle
```

Requires Typst 0.15 or later, specifically its `--features bundle`
export (still experimental).

= Full guide

The complete, progressive guide — a first checklist, marking items,
diagnostics, quoting the wording, the page-break idiom, styling the
grid, wiring a real project, the built-in checklists, and checkitoff in
the contexture ecosystem — starts at
#link(calepin.url("/checkitoff/quickstart/"))[Your first checklist].

= Combining with other packages

`checkitoff`'s `checklist(...)` combines cleanly with
#link(calepin.url("/palimpsest/"))[palimpsest]'s `letter(...)` and
#link(calepin.url("/colophon/"))[colophon]'s `report(...)` in the same compile. See
#link(calepin.url("/combining/"))[Combining packages].
