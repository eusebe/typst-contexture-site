#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Shortcuts: added, deleted, replaced, touched, suppressed])
#metadata((title: "Shortcuts: added, deleted, replaced, touched, suppressed", translation_key: "palimpsest-shortcuts")) <website-metadata>

#title()

`add`/`del`/`rep` mark part of a passage — a clause added mid-sentence,
one phrase replacing another. When the *entire* passage is new,
removed, or rewritten, wrapping it by hand (`passage(anchor)[#add[...]]`)
is one level of nesting that never varies — these five shortcuts skip
it.

/ `added(anchors, body, summary: none)`: `passage(anchors, add(body))`.
/ `deleted(anchors, body, summary: none)`: `passage(anchors, del(body))`.
/ `replaced(anchors, old, new, summary: none)`: `passage(anchors, rep(old, new))`.

#m.snippet("/packages/palimpsest/docs/manual-snippets/shortcuts-basics.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/shortcuts-basics/result-tracked.png")

`summary:` is accepted by all three but only matters once a passage's
tracked appearance gives a letter nothing worth quoting — `deleted` is
the common case, covered below under `suppressed`.

= touched

/ `touched(anchors, body)`: declares a location without marking any
  change — "we checked this, it stays as written." Unlike `passage` on
  its own, an anchor with no `add`/`del`/`rep` inside doesn't need
  `allow-empty:` to avoid a warning; `touched` already sets it.

#m.snippet("/packages/palimpsest/docs/manual-snippets/shortcuts-touched.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/shortcuts-touched/result-tracked.png")

Still colored and tagged like any other passage — just nothing struck
or underlined, since nothing changed.

= suppressed

/ `suppressed(anchors, note, summary: auto)`: `passage(anchors, suppress(note), summary: ...)`
  — `suppress`
  (#link("/palimpsest/marking/#suppress")[Marking changes], above) for
  a passage entirely made of it.

#m.snippet("/packages/palimpsest/docs/manual-snippets/shortcuts-suppressed.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/shortcuts-suppressed/result-tracked.png")

`note` and `summary:` are separate parameters on purpose. `note` has to
read on its own, cold, in the middle of the manuscript — "Equation
removed: ...". `summary:` is inserted into a sentence the *letter*
will already have written — "Removed: `‹summary›`" — so it should be a
bare phrase, not repeat "removed" itself. `summary:` defaults to `note`
when omitted, since most of the time the two don't need to differ; the
second call above gives them separately.

#m.chapter-nav(
  prev: ("/palimpsest/styling/", "Styling marks: set-revisions"),
  next: ("/palimpsest/exchanges/", "Writing the exchanges"),
)
