#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Anomalies])
#metadata((title: "Anomalies", translation_key: "colophon-anomalies")) <website-metadata>

#title()

Two structural facts colophon reports without judging them: a label
nothing ever points back to, and a bibliography entry nothing ever
cites. Neither is wired to `contexture.diagnose`/`strict` the way a
diagnostic elsewhere in this ecosystem might be — an orphan label or an
unused reference is often entirely deliberate (a supplementary figure
described elsewhere, a reference cited only in a cover letter rather
than the manuscript body), so colophon lists it and leaves the
judgment to you.

/ `orphan-labels(start, end)`: every labelled heading, figure, or
  equation in the manuscript's span that no `ref`/`@label` anywhere in
  the *whole bundle* ever targets — deliberately bundle-wide on the
  referencing side (a figure could legitimately be cited from another
  package's own satellite, an equator checklist excerpt say), only the
  candidate labels themselves are scoped to the manuscript.
/ `bib-keys(path)` / `uncited-references(path, start, end)`: every
  entry a `.bib` file defines that no `@key`/`cite(<key>)` in the
  manuscript's span actually cites. `path` must be root-relative (a
  leading `/`, resolved against `--root`) — the same gotcha
  #link("/palimpsest/bibliography/")[palimpsest's own
  `letter-bibliography`] already documents, for the same underlying
  reason: Typst resolves a path string against the file that calls the
  path-consuming builtin, not the file that wrote the literal.

A heading whose label is never referenced, a figure that is, and one
that isn't, plus one bibliography entry never cited:

#m.snippet("/packages/colophon/docs/manual-snippets/anomalies-basics.typ")

#m.screenshot("/packages/colophon/docs/manual-snippets/anomalies-basics/audit-plain.png")

`bib:`, passed to `report(...)`, is what turns the bibliography section
on at all — omitted (`none`, the default), the "Bibliography entries
never cited" heading doesn't appear, since not every manuscript has one
file to point at:

```typ
#report(bib: "/manuscript.bib")
```

#m.note(title: "An orphan figure never shows up here")[
  Look closely at the example above: `<fig-orphan>` is a genuine
  orphan — captioned "Orphan figure, never referenced anywhere," no
  `@fig-orphan` anywhere in the source — yet only the heading's label,
  `sec-intro`, appears in "Labels never referenced." This holds across
  every example in this manual that has an orphan figure, not just
  this one: figure-inventory
  (#link("/colophon/inventory/")[the previous chapter]) itself renders
  each figure's number via `ref(label)`, and that call is, structurally,
  a real reference to that same label — so the moment a figure appears
  in the "Figures and tables" section above, it already counts as
  "referenced" for this check's purposes, whether or not the
  manuscript's own prose ever points back to it. In practice: this
  check reliably catches an orphan heading or equation, but never an
  orphan figure or table specifically — for those, the "Figures and
  tables" section itself, read by eye, is the real inventory to check
  against.
]

#m.chapter-nav(
  prev: ("/colophon/inventory/", "Figure and table inventory"),
  next: ("/colophon/project/", "Wiring a real project"),
)
