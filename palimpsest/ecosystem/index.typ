#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Ecosystem])
#metadata((title: "Ecosystem", translation_key: "palimpsest-ecosystem")) <website-metadata>

#title()

Palimpsest is one of the packages built on `contexture`, a small shared
package none of them ship duplicated logic for. This chapter explains
what `contexture` actually contributes, introduces the other packages
built on it, and covers what changes when they're used together.

= What contexture does

Everything in this manual that looks up a *real* page number across two
documents — `response.pdf` citing exactly where in `manuscript.pdf` a
change landed — relies on Typst's experimental bundle export, which
lets one compile produce several documents that can query each other's
final layout. `contexture` is the small toolkit that turns that raw
capability into something a package author can build on without
reinventing it each time:

- an *anchor* primitive — mark a spot in one document, read it back
  from any other, by its real page; `pinpoint` and `xref` are both
  built directly on it;
- a *shared compile engine* (`bundle`) — the single point that ever
  calls Typst's own `document(...)`, so palimpsest's letter and, say,
  another package's own generated document can both be listed side by
  side without competing to own the compile;
- two independent *compile flags*, `variant` and `preview` — palimpsest
  reads `variant` for its own clean/tracked distinction
  (`--input variant=tracked` throughout this manual); `preview` is a
  second, independent axis a package can use for its own purposes
  (equator uses it for its `check()` highlighting, below);
- a shared *diagnostics* mechanism and `strict` flag — what every
  warning box and `strict: true` in this manual are actually built
  from.

`passage()`/`add()`/`del()`/`rep()` are built directly on `contexture`'s
anchor primitive; `letter(...)` is a thin description handed to its
shared compile engine. None of this needs to be learned to use
palimpsest as documented above — it's mentioned here because the same
foundation is shared with the packages below, which is what makes
combining them straightforward rather than a rewrite. Full manual:
#link("/contexture/")[contexture].

= equator: reporting-guideline checklists

`equator` is a sibling package for a different problem: filling in a
reporting-guideline grid (CONSORT, PRISMA, SPIRIT, STARD, STROBE...)
automatically, by marking where each item is answered in the manuscript
(`check(id, body)`) and letting the grid cite the real page each one
landed on. See #link("/equator/")[equator]'s own manual for the full
picture; nothing in it is needed to use palimpsest on its own.

= colophon: an audit of the composed manuscript

`colophon` is a third sibling: a manuscript-audit companion, needing no
per-passage markup at all — word counts, a figure/table inventory,
orphan labels, uncited references, computed from the same compile as
the manuscript, and reading exactly the *clean*, submitted text through
palimpsest's own marks. See #link("/colophon/")[colophon]'s own manual.

= Combining the two

Because `contexture.bundle` — not palimpsest — owns `documents:`,
adding a second package's own document alongside `letter(...)` is just
a second entry in the same array, not a second engine to reconcile.
Here, a CONSORT reporting checklist (`@preview/equator`) is produced
from the *same* manuscript, in the *same* compile, as the reviewer
response letter:

#m.snippet("/packages/palimpsest/docs/manual-snippets/contexture-with-equator.typ")

`manuscript.pdf` — item 1 is unrelated to the reviewer exchange, so
`equator.check(...)` just renders its own text at its own spot,
independently of `passage(...)`; item 2's text, though, genuinely *is*
the reviewer exchange, so it's rendered exactly once, by `passage(...)`
alone (see below for why):

#m.screenshot("/packages/palimpsest/docs/manual-snippets/contexture-with-equator/manuscript-clean.png")

`response.pdf`, citing the manuscript's real page as always:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/contexture-with-equator/response-clean.png")

`checklist.pdf`, generated entirely by equator, citing the same
manuscript page for both items regardless of which form of `check()`
produced each one:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/contexture-with-equator/checklist-clean.png")

Three documents, one manuscript, one compile — and
`--input variant=tracked`/`--input preview=true` (equator's own preview
flag, for its `check()` anchors) both still work exactly as shown
throughout this manual, independently of whichever other packages are
listed in `documents:`.

#m.note(title: "Never nest one package's marking function inside another's")[
  `#check(...)[#passage(...)[...]]` and the reverse each break something,
  for the same underlying reason both times: `passage()`'s own visual
  rendering, and `check()`'s own preview-mode highlighting, are each
  wrapped in a `context` block (needed to read live style state) — and
  a `context` block is structurally opaque to anything trying to
  inspect its contents *before* layout, the same limitation this manual
  already documents for `pinpoint`'s label handling. Nest `passage()`
  inside `check()` and `check()`'s own blank-content self-check can no
  longer see the real text inside — it misreports the passage as empty,
  in *any* mode, not just under `preview: true`. Nest `check()` inside
  `passage()` and, under `preview: true` specifically, `passage()`'s
  own scan for `add`/`del`/`rep` marks can no longer see them — it
  misreports "contains no mark". Two different symptoms, one cause, and
  no nesting order avoids it.
]

*But don't just call them as two independent, side-by-side renders on
the exact same span either* — both `check(id, body)` and `passage()`
render their own `body`; two calls on identical text print it twice, as
plain, visible duplication (item 1 above is fine precisely because it's
a *different* span from anything palimpsest touches — the common case,
and the one worth defaulting to whenever a checklist item and a
reviewer exchange simply don't coincide). When they do coincide — the
reviewer's requested change *is* the manuscript's answer to a checklist
item, item 2 above — use the bare `check(id)` (no second argument)
instead of `check(id, body)`: same metadata, same page resolution in
`checklist.pdf`, but it renders nothing but a small superscripted id
under `--input preview=true` — nothing that duplicates or nests.
`passage(...)` stays the one call that actually prints the text and
handles its tracked-mode marks; `check(id)` just tells equator where to
find it. `colophon` needs no such rule at all — it never renders
anything inside the manuscript body, so nothing to nest or duplicate
ever arises with it.

Not a palimpsest-specific rule: it applies to any two `contexture`-based
packages whose marking functions both render content over the same
span, present or future — the fix is the same shape every time, one
call renders, any other call that needs to know about that same span
registers via its own package's bare, non-rendering form instead of its
normal marking call (equator's own `check` folds both shapes into one
function, the same way palimpsest's own `passage(anchors, body)`/`passage(body)`
already does). A shorter, cross-package summary of both rules also
lives at #link("/combining/")[Combining packages].

= Where to go next

- The mechanics behind all of this, on their own, with no notion of
  revisions or checklists attached: #link("/contexture/")[contexture]'s
  manual.
- Reporting-guideline checklists that cite the real pages:
  #link("/equator/")[equator]'s manual.
- A word-count and inventory audit of the composed manuscript:
  #link("/colophon/")[colophon]'s manual.
- Everything about manuscript revisions and reviewer letters on their
  own: the rest of this manual, from
  #link("/palimpsest/quickstart/")[Your first revision round] onward.

#m.chapter-nav(
  prev: ("/palimpsest/project/", "Wiring a real project"),
  next: none,
)
