#import "/.calepin/calepin.typ" as calepin

#set document(title: [Combining packages])
#metadata((title: "Combining packages", translation_key: "combining")) <website-metadata>

#title()

Because `contexture.bundle` — not any one package — owns `documents:`,
adding a second (or third) package's own document alongside another's
is just one more entry in the same array, not a second engine to
reconcile:

```typ
#import "@preview/contexture:0.1.0": bundle
#import "@preview/palimpsest:0.1.0" as palimpsest
#import "@preview/equator:0.1.0" as equator
#import "@preview/colophon:0.1.0" as colophon

#show: bundle.with(
  template: colophon.instrument(template: my-journal-template),
  documents: (
    palimpsest.letter(exchanges: include "responses.typ"),
    equator.checklist(checklist: equator.checklists.consort),
    colophon.report(),
  ),
)

#include "manuscript.typ"
```

One compile, one manuscript: a tracked-changes version, a reviewer
response letter, a completed CONSORT grid, and a word-count audit — all
citing each other's real page numbers, none of the three packages aware
the other two exist.

= Two rules, once two packages might touch the same span

Both #link("/palimpsest/")[palimpsest]'s `passage()`/`add()`/`del()`/`rep()`
and #link("/equator/")[equator]'s `check()` render their own content,
which matters the moment they might cover the exact same passage — a
reviewer's requested change that genuinely _is_ the manuscript's answer
to a checklist item, say.

+ *Never nest one package's marking function inside another's*, in
  either direction. Each wraps its own rendering in a way the other's
  structural scan can't see through — nesting either way produces a
  false diagnostic.
+ *Don't call two of them as independent, rendering siblings on the
  exact same span, either.* Nothing stops you, and nothing diagnoses
  it — but both render their own body, so the same text prints twice.

For that second case, use the bare, non-rendering form instead —
`equator.check(id)` (no second argument): `passage(...)` stays the one
call that actually renders the text; `check(id)` only registers the
item's coverage, with nothing left to duplicate or nest. The same
pattern generalizes to any two `contexture`-based packages whose
marking functions both render content over the same span, present or
future.

= `colophon` is different: nothing to nest

`colophon.report()` needs no per-passage markup at all — it audits the
composed document, not passages you've marked. The only wiring it asks
for is wrapping the manuscript's own `template:` in
`colophon.instrument(...)`, as shown above; it never renders anything
inside the manuscript body, so the two rules above simply don't apply
to it.

= Full write-up

The complete version of this — the exact failure each rule prevents,
and a full worked example compiled end to end — lives in each
package's own manual for now (`contexture`'s "Composing independent
packages", `palimpsest`'s and `equator`'s own "Combining with another
`contexture` package" chapters), while this page is a summary migrated
ahead of the rest of the progressive guides.
