#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Bibliography])
#metadata((title: "Bibliography", translation_key: "palimpsest-bibliography")) <website-metadata>

#title()

Typst 0.15's multiple bibliographies handle three situations.

= A citation inside add/del

Nothing special to do — it becomes part of the manuscript's own
bibliography either way. The difference shows up in *which version*
the citation appears in:

#m.snippet("/packages/palimpsest/docs/manual-snippets/biblio-add-del.typ")

Clean — only the surviving citation:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/biblio-add-del/result-clean.png")

Tracked — both, since the struck-through text is still there to
resolve:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/biblio-add-del/result-tracked.png")

A citation inside a deleted passage disappears from the bibliography in
the clean compile and reappears in the tracked one, so a reader
following the struck-through text can still resolve what it cited —
the opposite of `latexdiff`, notorious for leaving phantom,
unresolvable references behind.

= letter-bibliography: a citation the letter makes on its own

/ `letter-bibliography(path, title: [References cited in this response])`:
  a second bibliography, scoped to citations made *inside* the letter
  and numbered independently from the manuscript's own.

A real project's three-file shape (`main.typ`/`manuscript.typ`/`responses.typ`,
covered in #link("/palimpsest/project/")[Wiring a real project] below)
— `manuscript.typ`:

#m.snippet("/packages/palimpsest/docs/manual-snippets/shared/biblio-letter/manuscript.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/biblio-letter/manuscript-clean.png")

`responses.typ`:

#m.snippet("/packages/palimpsest/docs/manual-snippets/shared/biblio-letter/responses.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/biblio-letter/response-clean.png")

`smith2020` is `[2]` in the manuscript's own bibliography but `[1]` in
the letter's — two independent numbering sequences, not one shared
list. This is also why `smith2020` had to be listed in *both* `.bib`
files even though the manuscript already cites it: a citation made
directly in the letter's own prose only ever resolves against the
`.bib` passed to `letter-bibliography`, regardless of what the
manuscript's own bibliography already knows.

#m.note(title: "Path gotcha")[
  `path` must be root-relative (a leading `/`, resolved against
  `--root`), not relative to the file that calls `letter-bibliography`.
  Typst resolves a path string against the file that calls the
  path-consuming builtin — here, `bibliography()` inside
  `letter-bibliography`, in the package's own source — not the file
  that wrote the string literal. A plain `"responses.bib"` looks next
  to the package's own source and fails.
]

= Letter numbering

A figure or table the letter adds *on its own* — "for the reviewer's
convenience only," never in the manuscript, like the table above — is
numbered independently from the manuscript's, prefixed `R`, so it can
never be confused with a manuscript one.

A figure, table, equation, or heading `pinpoint(excerpt: true)`
re-emits *from* the manuscript is different: it keeps the manuscript's
own real number, not an `R` one — "Figure 1" reads "Figure 1" in the
letter too, not "Figure R1", and a quoted subsection heading reads
"2.1" the same way it does in the manuscript:

#m.snippet("/packages/palimpsest/docs/manual-snippets/letter-numbering.typ")

Manuscript:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/letter-numbering/manuscript-clean.png")

Response:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/letter-numbering/response-clean.png")

The letter's own figure above is captioned "Figure R2," not "Figure
R1" — the two excerpts before it (the figure and the heading) still
occupy the first two slots of the letter's own counters, even though
what each *displays* is the manuscript's own number rather than that
slot's.

This requires a label on the original — `query()` is how the letter's
copy finds the manuscript's real number, and a label is what it
queries by. An unlabelled figure, equation, or heading just falls back
to whatever numbering already applies where the excerpt is re-emitted
— the letter's own `R` sequence for a figure or table, no `R` sequence
at all for an equation (equations never had one), and no number at all
for a heading. This matters most in practice for headings: a figure is
usually labelled anyway, for `@ref`, but a heading rarely is unless an
author adds one specifically so it can be quoted this way.

#m.chapter-nav(
  prev: ("/palimpsest/tables/", "Working with tables"),
  next: ("/palimpsest/diagnostics/", "Diagnostics and strict mode"),
)
