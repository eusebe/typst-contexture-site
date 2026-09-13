#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [The abstract])
#metadata((title: "The abstract", translation_key: "colophon-abstract")) <website-metadata>

#title()

An abstract is routinely capped by its own, independent word limit —
separate from the manuscript body's own. Getting a count for it
separately needs one small, deliberate step, because of *how* most
templates actually take an abstract: as a `template.with(abstract:
...)` parameter, evaluated and handed to the template *before*
`instrument()`'s own `template:` ever runs — never part of the
manuscript `body` colophon's word count walks at all. There's no
generic way to detect "this content is the abstract" after the fact,
so colophon asks for one explicit marker instead:

/ `abstract(body)`: renders `body` completely unchanged — visually
  identical to writing `abstract: my-text` directly — but drops an
  invisible marker `report()` can find later, so this content gets its
  own word count.
/ `abstract-word-count(start, end, count-captions: false)`: what
  `render-report(...)` calls internally to produce the "Abstract word
  count" row; exposed on its own for a project that wants the number
  outside the usual report layout. `none` if `abstract(...)` was never
  used anywhere in the manuscript — not an error, most manuscripts in
  colophon's own tests have none.

A minimal example — the abstract written directly in the manuscript,
under its own heading, the simplest case:

#m.snippet("/packages/colophon/docs/manual-snippets/abstract-basics.typ")

#m.screenshot("/packages/colophon/docs/manual-snippets/abstract-basics/audit-plain.png")

#m.note(title: "The abstract never gets its own row in \"Word count by section\"")[
  Worth spelling out, since it's easy to expect otherwise: even written
  as an ordinary `= Abstract` heading followed by prose, the text
  wrapped in `abstract(...)` doesn't show up as an "Abstract" row in
  the per-section table above — only the separate "Abstract word
  count" statistic reports it. That's deliberate, not an oversight:
  `abstract(...)` renders its visible content wrapped in `context`,
  specifically so the general per-section walk — which would otherwise
  double-count it, once here and once in the dedicated abstract count
  — simply never sees it. The heading still exists in the real
  manuscript, exactly as written; it just contributes nothing of its
  own to the body breakdown.
]

= As a template parameter

The far more common case in practice — wrap it exactly the same way,
right where the template asks for it:

```typ
#let my-template = some-journal-template.with(
  abstract: abstract(lorem(150)),   // wrap wherever you already write it
  ...
)
```

Nothing else changes: `report()` finds it the same way either way,
since the marker itself, not where it happens to sit, is what
`abstract-word-count` looks for.

#m.chapter-nav(
  prev: ("/colophon/word-counts/", "Word counts"),
  next: ("/colophon/inventory/", "Figure and table inventory"),
)
