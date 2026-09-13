#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Equator in the contexture ecosystem])
#metadata((title: "Equator in the contexture ecosystem", translation_key: "equator-ecosystem")) <website-metadata>

#title()

Equator is one of the packages built on `contexture`, a small shared
package none of them ship duplicated logic for. This chapter explains
what `contexture` actually contributes, introduces the other packages
built on it, and covers what changes when they're used together.

= What contexture does

Everything in this manual that looks up a *real* page number across two
documents — `checklist.pdf` citing exactly where in `manuscript.pdf`
each item landed — relies on Typst's experimental bundle export, which
lets one compile produce several documents that can query each other's
final layout. `contexture` is the small toolkit that turns that raw
capability into something a package author can build on without
reinventing it each time:

- an *anchor* primitive — mark a spot in one document, read it back
  from any other, by its real page;
- a *shared compile pilot* (`bundle`) — the single point that ever
  calls Typst's own `document(...)`, so that equator's grid and, say,
  another package's own generated document can both be listed side by
  side without competing to own the compile;
- two independent *compile flags*, `variant` and `preview` — `preview`
  is what powers `--input preview=true` throughout this manual;
  `variant` is a second, independent axis a package can use for its own
  purposes (palimpsest uses it for clean vs. tracked-changes output,
  below);
- a shared *diagnostics* mechanism and `strict` flag — what every
  warning marker and `strict: true` in this manual are actually built
  from.

`equator.check()` is a thin wrapper around `contexture`'s anchor
primitive; `checklist(...)` is a thin wrapper around its shared compile
pilot. None of this needs to be learned to use equator as documented
above — it's mentioned here because the same foundation is shared with
the packages below, which is what makes combining them straightforward
rather than a rewrite. Full manual:
#link("/contexture/")[contexture].

= palimpsest: manuscript revisions and reviewer letters

`palimpsest` is a sibling package for a different problem: tracking
changes made to a manuscript during peer review (`add`, `del`, `rep`,
anchored to a specific reviewer comment), and generating the
tracked-changes manuscript and a reviewer response letter that cites
the manuscript's real pages — down to quoting the exact revised wording
next to each response, if wanted. See
#link("/palimpsest/")[palimpsest]'s own manual for the full picture;
nothing in it is needed to use equator on its own.

= colophon: an audit of the composed manuscript

`colophon` is a third sibling: a manuscript-audit companion, needing no
per-passage markup at all — word counts, a figure/table inventory,
orphan labels, uncited references, computed from the same compile as
the manuscript. It combines with `checklist(...)` the same way
`letter(...)` does, below. See #link("/colophon/")[colophon]'s own
manual.

= Combining checklist(...) with the others

`checklist(...)`, palimpsest's `letter(...)`, and colophon's `report()`
are all just descriptions of a document to build, in the same sense
`checklist(...)` was introduced in
#link("/equator/project/")[Wiring a real project] — listing them
together under the same `documents:` produces, from one compile, a
manuscript, its tracked-changes companion, a reviewer response letter, a
completed reporting-guideline grid, and a word-count audit, all citing
each other's real page numbers:

```typ
#show: contexture.bundle.with(
  documents: (
    palimpsest.letter(exchanges: my-exchanges),
    equator.checklist(checklist: checklists.consort),
    colophon.report(),
  ),
)

#include "manuscript.typ"
```

Two rules matter once `checklist(...)` and another package's own
marking function might touch the same span of text — `check(...)` and
palimpsest's `passage(...)`, most concretely:

+ *Never nest `check(...)` and `passage(...)` inside each other's body,
  in either direction.* Each wraps its own rendering in a way the
  other's structural scan can't see through, so nesting either way
  produces a false diagnostic.
+ *Don't call `check(...)` and `passage(...)` as two independent,
  rendering siblings on the exact same wording, either.* Nothing stops
  you, and nothing diagnoses it — but both functions render their own
  body, so the same text prints twice, plainly duplicated in
  `manuscript.pdf`. This only bites when a reviewer's requested change
  genuinely *is* the manuscript's answer to a checklist item; two
  unrelated spans, the common case, have nothing to duplicate.

For that second case, use the bare `check(id)` form instead
(#link("/equator/marking/#the-point-marker-form-check-id-alone")[introduced
earlier]): `passage(...)` stays the one call that renders the text and
carries its tracked-changes marks, `check(id)` only registers the
item's coverage, with nothing left to duplicate or nest. `colophon`
needs no such rule at all: it never renders anything inside the
manuscript body, so nothing to nest or duplicate ever arises with it.

`@preview/contexture`'s own manual walks through this exact combination
end to end, including compiling the tracked-and-preview manuscript
together, in its chapter "Composing independent packages" — the
package-agnostic version of the two rules above. `@preview/palimpsest`'s
manual covers its own side of it, under "Combining with another
contexture package." A shorter, cross-package summary also lives at
#link("/combining/")[Combining packages].

= Where to go next

- The mechanics behind all of this, on their own, with no notion of
  checklists or revisions attached: #link("/contexture/")[contexture]'s
  manual.
- Tracked manuscript revisions and reviewer response letters that cite
  the real pages: #link("/palimpsest/")[palimpsest]'s manual.
- A word-count and inventory audit of the composed manuscript:
  #link("/colophon/")[colophon]'s manual.
- Everything about reporting-guideline checklists on their own: the rest
  of this manual, from #link("/equator/quickstart/")[Your first
  checklist] onward.

#m.chapter-nav(
  prev: ("/equator/checklists/", "Built-in checklists"),
  next: none,
)
