#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Wiring a real project])
#metadata((title: "Wiring a real project", translation_key: "palimpsest-project")) <website-metadata>

#title()

Every example so far ran `add`/`del`/`passage`/`change-list`/... directly,
in a single plain file, no bundle. A real project instead wires
everything together explicitly, in two parts: `contexture.bundle` —
imported from `@preview/contexture`, palimpsest's own dependency — is
the only function anywhere in this ecosystem that ever calls Typst's
own `document(...)`; it owns the manuscript, and builds one more
document per entry listed under `documents:`. Palimpsest's own
`letter(...)` doesn't build anything by itself — it just *describes*
the response letter as one such entry. That split is what lets a
second package add its own document the same way — checkitoff's
reporting-guideline checklist, say — by adding a second entry to the
same list, with no risk of two competing functions each trying to call
`document(...)` on their own (see
#link(calepin.url("/combining/"))[Combining packages] for a full worked
example).

A project is normally three files:

```
manuscript.typ    the manuscript, annotated with passage()/add()/del()/...
responses.typ     the exchanges with reviewers
main.typ          the wiring (a handful of lines)
```

`main.typ`:

#m.snippet("/packages/palimpsest/docs/manual-snippets/revisions-pilot.typ")

`manuscript.typ`:

#m.snippet("/packages/palimpsest/docs/manual-snippets/shared/manuscript.typ")

`responses.typ`:

#m.snippet("/packages/palimpsest/docs/manual-snippets/shared/responses.typ")

Two commands, run one after the other, produce the whole project:

```sh
typst compile --features bundle --format bundle main.typ
typst compile --features bundle --format bundle --input variant=tracked main.typ
```

*First command* (`variant` defaults to `"clean"`) — `manuscript.pdf`:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/revisions-pilot/manuscript-clean.png")

— and `response.pdf`:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/revisions-pilot/response-clean.png")

*Second command* (`--input variant=tracked`) — `manuscript-tracked.pdf`:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/revisions-pilot/manuscript-tracked.png")

— and, since `exchanges` is set, `response-tracked.pdf`: the same
letter, but citing and quoting *this* manuscript, the tracked one — see
below for why that happens automatically, with no separate setting:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/revisions-pilot/response-tracked.png")

Each compile produces exactly the file(s) for its own variant, never a
mix of the two — the first never produces a tracked manuscript, and
neither compile's letter is named the same as the other's.

`contexture.bundle`'s own parameters (shared by every package built on
it, not specific to palimpsest):

/ `template`: wraps the manuscript only — any `content -> content`
  function, including a real journal template used the normal way.
  `authors:`/`title:` above are this example's own stand-in template's
  parameters, not `bundle`'s.
/ `documents`: an array of satellite descriptions — `letter(...)` here,
  possibly alongside others (see
  #link(calepin.url("/combining/"))[Combining packages]). `()`, the
  default, produces the manuscript alone.
/ `strict`: `bundle(strict: true, ...)` turns every diagnostic raised
  by *any* listed satellite, and by palimpsest's own marks/exchanges,
  into a hard compile error — see
  #link(calepin.url("/palimpsest/diagnostics/"))[Diagnostics and strict mode] above.

`letter(...)`'s own parameters, palimpsest-specific:

/ `exchanges`: the already-evaluated content of the responses file —
  `include "responses.typ"`, as shown above. Also decides whether a
  letter is produced at all — see below.
/ `template`: wraps the letter only, separately from the manuscript's
  own `template:` above — `auto` (the default) uses
  `default-letter-template`, a title and nothing else. The two
  templates never mix: a figure/table/heading style set inside one has
  no effect on the other.

Each source file needs its own `#import "@preview/palimpsest:0.1.0": *`
— `#include` doesn't share scope, so `manuscript.typ` and
`responses.typ` both import it too, even though only `main.typ` calls
`letter`/`bundle`. Only `main.typ` needs `contexture` itself.

= The letter, automatically — matched to the manuscript you actually send

Whether a compile produces a response document isn't something you
configure — there's nothing sensible for it to mean independently of
`exchanges`: writing responses with no letter to hold them, or asking
for a letter with nothing written, are both non-cases. So it's derived:
`letter(...)`'s own `applicable` rule builds a letter whenever
`exchanges` isn't `none`, matching *this compile's own* variant —
`response.pdf` from the clean compile, `response-tracked.pdf` from the
tracked one, each citing and quoting its own manuscript. This changes
nothing about the command line — it's still the exact same two commands
shown above.

#m.snippet("/packages/palimpsest/docs/manual-snippets/revisions-exchanges-letter.typ")

Compiled clean, `response.pdf` quotes the accepted wording only:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/revisions-exchanges-letter/response-clean.png")

Compiled with `--input variant=tracked`, the same `exchanges` also
produces `response-tracked.pdf` — a name distinct from `response.pdf`,
so neither compile can silently overwrite the other's output. Its
excerpt shows the struck-through old wording next to the underlined new
wording, because `pinpoint(excerpt: true)` with no explicit `mode:`
always follows whichever mode the *current* compile is running under
(see #link(calepin.url("/palimpsest/pinpoint/#page-only-by-default"))[pinpoint]
above):

#m.screenshot("/packages/palimpsest/docs/manual-snippets/revisions-exchanges-letter/response-tracked.png")

The one thing that *is* a command-line choice, not a fixed property of
the project, is skipping the letter for a single run even though
`exchanges` is set — a fast, manuscript-only preview while drafting,
without touching `main.typ`. This is `contexture.bundle`'s own
mechanism, `--input only=`, not something specific to the letter —
listing nothing after the `=` means "the manuscript alone, whatever's
in `documents:`":

```sh
typst compile --features bundle --format bundle --input only= main.typ
```

Naming a satellite explicitly (`--input only=response`) restricts the
compile to just that one, still subject to its own rules (a satellite
gated on something else, like checkitoff's checklist below, doesn't get
forced on just because it's named here).

What each command writes, with `exchanges` set:

#table(
  columns: (1fr, 1fr, 1fr),
  stroke: 0.75pt + luma(120),
  align: horizon,
  table.header[*Command*][*default*][*`--input only=`*],
  [1st (clean)], [`manuscript.pdf`\ `response.pdf`], [`manuscript.pdf`],
  [2nd (tracked)], [`manuscript-tracked.pdf`\ `response-tracked.pdf`], [`manuscript-tracked.pdf`],
)

#m.chapter-nav(
  prev: ("/palimpsest/diagnostics/", "Diagnostics and strict mode"),
  next: ("/palimpsest/ecosystem/", "Ecosystem"),
)
