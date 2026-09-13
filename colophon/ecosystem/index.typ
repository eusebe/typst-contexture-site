#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [colophon in the contexture ecosystem])
#metadata((title: "colophon in the contexture ecosystem", translation_key: "colophon-ecosystem")) <website-metadata>

#title()

colophon is one of the packages built on `contexture`, a small shared
package none of them ship duplicated logic for. This chapter explains
what `contexture` actually contributes, introduces the other packages
built on it, and covers what changes when they're used together.

= What contexture does

Everything in this manual that reports a *real* page count or figure
number — `audit.pdf` citing exactly how many pages `manuscript.pdf`
actually laid out to — relies on Typst's experimental bundle export,
which lets one compile produce several documents that can query each
other's final layout. `contexture` is the small toolkit that turns that
raw capability into something a package author can build on without
reinventing it each time:

- a *shared compile pilot* (`bundle`) — the single point that ever
  calls Typst's own `document(...)`, so colophon's report and, say,
  another package's own generated document can both be listed side by
  side without competing to own the compile;
- two independent *compile flags*, `variant` and `preview` — what
  `report()`'s own `applicable` rule
  (#link("/colophon/project/")[Wiring a real project]) reads to build
  only from the one, real, plain compile.

Unlike #link("/palimpsest/")[palimpsest] and #link("/equator/")[equator],
colophon doesn't use `contexture`'s *anchor* primitive at all — it has
no per-passage markup to anchor, since it audits the composed document
rather than passages an author marked. Full manual:
#link("/contexture/")[contexture].

= palimpsest and equator

`palimpsest` tracks changes made to a manuscript during peer review and
generates a reviewer response letter that cites the manuscript's real
pages. `equator` fills in a reporting-guideline checklist (CONSORT,
PRISMA, SPIRIT, STARD, STROBE...), also citing the real pages. See
#link("/palimpsest/")[palimpsest]'s and #link("/equator/")[equator]'s
own manuals for the full picture; nothing in either is needed to use
colophon on its own — and, as
#link("/colophon/word-counts/")[Word counts] already showed, colophon
reads straight through palimpsest's own marks when both are used
together.

= Combining all three

Because `contexture.bundle` — not any one package — owns `documents:`,
adding colophon's report alongside a reviewer letter and a checklist is
just one more entry in the same array:

#m.snippet("/packages/colophon/docs/manual-snippets/triple-combo.typ")

One compile, four documents — the manuscript, palimpsest's response
letter, equator's completed CONSORT grid, and colophon's audit, all
from the same compile, all citing each other's real pages:

#m.screenshot("/packages/colophon/docs/manual-snippets/triple-combo/audit-plain.png")

#m.note(title: "colophon needs no nesting rule")[
  #link("/palimpsest/")[palimpsest]'s `passage()` and
  #link("/equator/")[equator]'s `check()` both render their own
  content, which is exactly why combining *them* needs two rules —
  never nest one's marking function inside the other's, and never call
  both as independent, rendering siblings on the same span (see
  #link("/combining/")[Combining packages] for the full reasoning).
  `report()` renders nothing inside the manuscript body at all — it
  only reads what `instrument()` captured and what the composed
  document already contains — so neither rule has anything to apply
  to. The only wiring colophon ever asks for is the one `instrument()`
  wrap on `template:`, shown throughout this manual.
]

= Where to go next

- The mechanics behind all of this, on their own, with no notion of
  revisions, checklists, or audits attached:
  #link("/contexture/")[contexture]'s manual.
- Tracked manuscript revisions and reviewer response letters that cite
  the real pages: #link("/palimpsest/")[palimpsest]'s manual.
- Reporting-guideline checklists that cite the real pages:
  #link("/equator/")[equator]'s manual.
- Everything about auditing a manuscript on its own: the rest of this
  manual, from #link("/colophon/quickstart/")[Quickstart] onward.

#m.chapter-nav(
  prev: ("/colophon/project/", "Wiring a real project"),
  next: none,
)
