#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Combining packages])
#metadata((title: "Combining packages", translation_key: "combining")) <website-metadata>

#title()

Each of #link(calepin.url("/palimpsest/"))[palimpsest],
#link(calepin.url("/checkitoff/"))[checkitoff], and
#link(calepin.url("/colophon/"))[colophon] is documented on its own, and
none of them needs this page: every example in their own manuals
compiles alone, with only that one package installed. This page is for
the moment you want more than one of them on the *same* manuscript, in
the *same* compile — a tracked-changes revision letter, a completed
CONSORT grid, and a word-count audit, all citing the same real page
numbers.

Because `contexture.bundle` — not any one package — owns `documents:`,
adding a second (or third) package's own document alongside another's
is just one more entry in the same array, not a second engine to
reconcile:

```typ
#import "@preview/contexture:0.1.0": bundle
#import "@preview/palimpsest:0.1.0" as palimpsest
#import "@preview/checkitoff:0.1.0" as checkitoff
#import "@preview/colophon:0.1.0" as colophon

#show: bundle.with(
  template: colophon.instrument(template: my-journal-template),
  documents: (
    palimpsest.letter(exchanges: include "responses.typ"),
    checkitoff.checklist(checklist: checkitoff.checklists.consort),
    colophon.report(),
  ),
)

#include "manuscript.typ"
```

One compile, one manuscript: a tracked-changes version, a reviewer
response letter, a completed CONSORT grid, and a word-count audit — all
citing each other's real page numbers, none of the three packages aware
the other two exist.

= What works

- *Listing any number of packages' documents under `documents:`.* Tested
  with all three at once — see the worked example below.
- *`colophon.report()` next to either or both of the others, always.*
  It never renders anything inside the manuscript body — it only reads
  what `instrument()` captured and what the composed document already
  contains — so it has no marking function to nest or duplicate, and
  needs no rule at all.
- *Two packages' marking functions on different spans of text* — a
  checklist item `checkitoff.check(id, body)` covers, and a change
  `palimpsest.passage(...)` covers, are unrelated. Each renders its own
  content independently; nothing to coordinate.
- *Compile flags stay independent.* `palimpsest`'s `variant` and
  `checkitoff`'s `preview` are two different axes, read from the same
  shared `--input`, and compose freely —
  `--input variant=tracked --input preview=true` together produce the
  tracked manuscript with checkitoff's drafting overlay on top,
  regardless of which other packages are listed in `documents:`.
- *The bare, non-rendering form of a marking function*, on a span
  already rendered by another package — `checkitoff.check(id)` (no
  second argument) registers a checklist item's coverage without
  printing anything; use it on a span `palimpsest.passage(...)` already
  renders, when a reviewer's requested change genuinely _is_ the
  manuscript's answer to that checklist item.

= What doesn't work

- *Nesting one package's marking function inside another's*, in either
  direction — `#checkitoff.check(id)[#palimpsest.passage(...)[...]]` or
  the reverse. Both break, for the same underlying reason: `passage()`'s
  own rendering and `check()`'s own preview-mode highlighting are each
  wrapped in a `context` block (needed to read live style state), and a
  `context` block is structurally opaque to anything trying to inspect
  its contents *before* layout. Nest `passage()` inside `check()` and
  `check()`'s own blank-content self-check can no longer see the real
  text inside — it misreports the passage as empty, in *any* mode, not
  just under `preview: true`. Nest `check()` inside `passage()` and,
  under `preview: true` specifically, `passage()`'s own scan for
  `add`/`del`/`rep` marks can no longer see them — it misreports
  "contains no mark". Two different symptoms, one cause, and no nesting
  order avoids it.
- *Calling two marking functions as independent, rendering siblings on
  the exact same span.* Nothing stops you, and nothing diagnoses it —
  but both `check(id, body)` and `passage(...)` render their own `body`,
  so the same text prints twice, as plain, visible duplication. Use the
  bare `check(id)` form on one side instead (see above).

Not palimpsest/checkitoff-specific: both rules apply to any two
`contexture`-based packages whose marking functions each render content
over the same span, present or future — the fix is the same shape every
time, one call renders, any other call that needs to know about that
same span registers via its own package's bare, non-rendering form
instead of its normal marking call.

= A full worked example

All three packages together, on the same manuscript, in one compile —
a tracked-changes revision, a reviewer response letter, a completed
CONSORT grid, and a word-count audit:

#m.snippet("/packages/colophon/docs/manual-snippets/triple-combo.typ")

`manuscript.pdf`, compiled plain — the real, submitted text, with
nothing of the reviewer exchange or the checklist visible:

#m.screenshot("/packages/colophon/docs/manual-snippets/triple-combo/manuscript-plain-1.png")

The same compile again with `--input variant=tracked` shows exactly
what changed, colored by reviewer:

#m.screenshot("/packages/colophon/docs/manual-snippets/triple-combo/manuscript-tracked-1.png")

`response.pdf`, from the very same compile, citing the manuscript's
real pages:

#m.screenshot("/packages/colophon/docs/manual-snippets/triple-combo/response-plain.png", width: 75%)

And `audit.pdf`, reading straight through palimpsest's own marks — the
word count matches the *clean*, submitted manuscript, not the tracked
one:

#m.screenshot("/packages/colophon/docs/manual-snippets/triple-combo/audit-plain.png")

= See also

`contexture`'s own manual walks through the same mechanism from the
other side — the anchor primitive and shared compile pilot that make
this possible in the first place, with a two-package worked example of
its own — in
#link(calepin.url("/contexture/composing/"))[Composing independent packages].
