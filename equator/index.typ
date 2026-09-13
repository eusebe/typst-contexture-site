#import "/.calepin/calepin.typ" as calepin

#set document(title: [equator])
#metadata((title: "equator", translation_key: "equator")) <website-metadata>

#title()

*equator* fills in a reporting-guideline checklist — CONSORT, PRISMA,
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
#import "@preview/equator:0.1.0": *
#import "@preview/contexture:0.1.0": bundle
```

Requires Typst 0.15 or later, specifically its `--features bundle`
export (still experimental).

= Full manual

The complete, progressive manual — a first checklist, diagnostics,
styling, wiring a real project, combining with `palimpsest` — lives in
the repository for now, while this site's own guide is still being
migrated over:
#link("https://github.com/eusebe/typst-equator/blob/main/docs/manual.pdf")[docs/manual.pdf]
(#link("https://github.com/eusebe/typst-equator")[repository]).

= Combining with other packages

`equator`'s `checklist(...)` combines cleanly with
#link("/palimpsest/")[palimpsest]'s `letter(...)` and
#link("/colophon/")[colophon]'s `report(...)` in the same compile. See
#link("/combining/")[Combining packages].
