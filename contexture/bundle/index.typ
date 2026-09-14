#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [satellite and bundle])
#metadata((title: "satellite and bundle", translation_key: "contexture-bundle")) <website-metadata>

#title()

`document(...)` — Typst's own primitive for naming one output of a
bundle compile — cannot be nested inside another `document(...)` call.
That rules out letting several independent pieces of code each call
`document(...)` on their own: whichever runs second would be trying to
nest its document inside whatever the first one already produced.
`contexture.bundle` is the fix: the *only* place that ever calls
`document(...)`. Anything built on `contexture` instead exposes a
small constructor that returns a `satellite(...)` value — inert data,
not a `document(...)` call — and the author lists as many of those as
they like under one shared `documents:`, exactly as
#link("/contexture/quickstart/")[the quickstart] above already did
with `glossary`.

/ `satellite(name, render:, applicable:, side-content: none)`:
  describes one document to build alongside the manuscript. `name` is
  the base filename (`bundle` appends the variant/preview suffix, see
  next chapter). `render() -> content` produces this document's
  content, called only when `applicable() -> bool` (default: always)
  says yes for the current compile.
/ `bundle(template:, documents: (), strict: false, manuscript-name: "manuscript", body)`:
  the pilot itself, called via `#show: bundle.with(...)` — `body` is
  the rest of the document, typically `#include "manuscript.typ"`.
  Builds the manuscript (`template(body)`) plus every satellite whose
  `applicable` returns true, each as its own real document sharing this
  one compile's introspection space with all the others.

`manuscript-name:` is the *only* thing that decides the manuscript's
output filename — it has no connection at all to the name of whatever
`.typ` file you actually run `typst compile` on (every example in this
manual compiles the snippet file shown directly, e.g.
`bundle-glossary-basics.typ`, and still produces `manuscript.pdf`). A
project that keeps its manuscript's prose in its own file, `#include`d
into `body`, is free to name that file anything — calling it
`manuscript.typ` is only a common convention, not a requirement
`bundle()` checks for. Every example in this manual takes the simplest
route instead: the file you see printed *is* the file compiled, with
the manuscript's own content written directly after
`#show: bundle.with(...)`, no separate `#include` at all.

#m.note(title: "Restricting a compile to fewer documents")[
  `--input only=<comma-separated satellite names>` restricts a single
  compile to the manuscript plus just the named satellites —
  `--input only=` with nothing after it produces the manuscript alone,
  whatever `documents:` lists. A command-line choice for a fast
  preview, not a property of the project: naming a satellite under
  `only:` that declines to build itself this compile (its own
  `applicable` says no) doesn't force it to.
]

#m.note(title: "side-content")[
  Content a satellite wants placed in the manuscript regardless of
  whether *it itself* gets built this compile. Useful when a satellite
  defines anchors that something elsewhere in the manuscript depends on
  for a check of its own (e.g. "does this passage have a matching
  answer somewhere?") — skip the satellite via `only=` and, without
  `side-content`, that check would wrongly report every single one of
  them as missing, purely because the satellite that would have
  answered them wasn't built this time. Paired with
  `collect-anchors(body, kind)` — the structural counterpart to
  `anchors`, finding anchors already sitting inside an in-memory `body`
  that was never placed into any document — and `reemit(collected)`,
  which registers one such found anchor as if it had been placed here.
]

#m.chapter-nav(
  prev: ("/contexture/list-of-figures/", "List of figures"),
  next: ("/contexture/variant-preview/", "Two independent compile axes"),
)
