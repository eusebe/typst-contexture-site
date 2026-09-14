#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Composing independent packages])
#metadata((title: "Composing independent packages", translation_key: "contexture-composing")) <website-metadata>

#title()

Everything in this manual so far is self-contained — no example so far
needed anything beyond `contexture` itself. In practice, `contexture`
is meant as a shared foundation that several packages build on at
once. #link("/palimpsest/")[palimpsest] (manuscript revision letters)
and #link("/equator/")[equator] (reporting-guideline checklists) are
two such packages, published independently of each other and of
`contexture`, neither aware the other exists. Combining them needs
nothing beyond listing both of their satellites under the same
`documents:` — the scenario the whole design exists for:

#m.snippet("/packages/contexture/docs/manual-snippets/bundle-combo-palimpsest-equator.typ")

One compile, four ways, exactly like
#link("/contexture/variant-preview/")[Two independent compile axes]
above, now with two real packages instead of a self-contained
demonstration:

#table(
  columns: (auto, 1fr),
  align: (left, left),
  stroke: 0.5pt + gray,
  table.header[*Compile*][*Files produced*],
  [(no flags)], [`manuscript.pdf`, `response.pdf`, `checklist.pdf`],
  [`--input variant=tracked`], [`manuscript-tracked.pdf`, `response-tracked.pdf`],
  [`--input preview=true`], [`manuscript-preview.pdf`, `response-preview.pdf`],
  [`--input variant=tracked --input preview=true`], [`manuscript-tracked-preview.pdf`, `response-tracked-preview.pdf`],
)

The last compile shows both packages' overlays together, in the same
document, each independent of the other:

#m.screenshot("/packages/contexture/docs/manual-snippets/bundle-combo-palimpsest-equator/manuscript-tracked-preview.png")

Building a marking function that renders its own content, the way
`passage()` and `check()` both do here, raises exactly one extra
question that a single-package example never has to answer: what
happens when two such functions from two different packages meet on
the same document, or even the same span? Two rules keep that safe —
never nest one package's marking function inside another's, and never
call two of them as independent, rendering siblings on the exact same
span (one of them needs a body-free form instead, to register coverage
without printing the text twice). Both rules, why they're necessary,
and the exact two-shape pattern (`check(id)` vs. `check(id, body)`)
that resolves the second one, are documented where they belong: in
palimpsest's and equator's own manuals, each under a section called
"Combining with another contexture package"
(#link("/palimpsest/ecosystem/#combining-the-two")[palimpsest],
#link("/equator/ecosystem/#combining-checklist-with-the-others")[equator]),
and summarized once, package-agnostically, at
#link("/combining/")[Combining packages].

= Where to go next

This manual covers `contexture` on its own — everything above works
with no other package installed. For what to build with it:

- Manuscript revisions and a reviewer response letter that cites the
  real pages: #link("/palimpsest/")[palimpsest]'s own manual.
- Reporting-guideline checklists (CONSORT, PRISMA, SPIRIT, STARD,
  STROBE) that cite the real pages: #link("/equator/")[equator]'s own
  manual.
- A word-count and inventory audit of the composed manuscript, needing
  no per-passage markup at all: #link("/colophon/")[colophon]'s own
  manual.
- Combining several such packages in one compile: this chapter above,
  and the "Combining with another contexture package" section in each
  package's own manual.

#m.chapter-nav(
  prev: ("/contexture/xref/", "xref"),
  next: none,
)
