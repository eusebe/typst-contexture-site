#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Two independent compile axes: variant, preview])
#metadata((title: "Two independent compile axes: variant, preview", translation_key: "contexture-variant-preview")) <website-metadata>

#title()

Two flags are available to any document built on `contexture`, read by
two plain functions:

/ `variant()`: which *version of the truth* this compile is producing
  — an intrinsic property of what the content itself means. `"plain"`
  by default (`--input variant=...` to change it); a project defines
  whatever other values make sense to it and reads them back with
  `variant() == "..."`. Code with no notion of variants never touches
  this at all, and always sees `"plain"`.
/ `preview()`: `true`/`false`, from `--input preview=true`. A drafting
  aid only: "show me my own working, temporarily" — never a reason to
  change what a document's content *means* (that's `variant`'s job),
  only how much of the plumbing is made visible while writing.

The difference in one sentence: `variant` decides *whether something
is there at all*; `preview` decides *how much you can see of how it
got there*. They're independent on purpose, so a project can cross
them freely rather than picking one axis and losing the other.

A small worked example, built on the same `term()` as
#link("/contexture/quickstart/")[the quickstart], plus one new function
that only exists to make the difference concrete:

#m.snippet("/packages/contexture/docs/manual-snippets/bundle-variant-preview.typ")

`term()` highlights its own body whenever `preview()` is on — a debug
view of where the anchors are, nothing else changes. `note()` is a
document aside that only renders — box, text, and all — when
`variant()` is `"internal"`; its anchor is still registered on every
compile, so `open-notes` can always find it, but its content genuinely
doesn't exist outside the internal variant. `open-notes` itself only
builds under `variant() == "internal"` — a document listing every open
note has nothing to say about a variant that has none.

Compiling this one file four ways produces four different, genuinely
independent combinations:

#table(
  columns: (auto, 1fr),
  align: (left, left),
  stroke: 0.5pt + gray,
  table.header[*Compile*][*Files produced*],
  [(no flags)], [`manuscript.pdf`],
  [`--input variant=internal`], [`manuscript-internal.pdf`, `open-notes-internal.pdf`],
  [`--input preview=true`], [`manuscript-preview.pdf`],
  [`--input variant=internal --input preview=true`], [`manuscript-internal-preview.pdf`, `open-notes-internal-preview.pdf`],
)

#m.side-by-side(
  m.screenshot("/packages/contexture/docs/manual-snippets/bundle-variant-preview/manuscript.png", caption: [(no flags)]),
  m.screenshot("/packages/contexture/docs/manual-snippets/bundle-variant-preview/manuscript-preview.png", caption: [preview=true]),
)
#m.side-by-side(
  m.screenshot("/packages/contexture/docs/manual-snippets/bundle-variant-preview/manuscript-internal.png", caption: [variant=internal]),
  m.screenshot("/packages/contexture/docs/manual-snippets/bundle-variant-preview/manuscript-internal-preview.png", caption: [both together]),
)

Notice what stays constant across each pair: turning `preview` on
never makes the reviewer note appear — that's `variant`'s call, not
`preview`'s — and switching to the internal variant never highlights
the terms on its own. Only the fourth compile, with both flags, shows
both effects at once, each exactly as it looks alone. That independence
is the entire reason these are two flags rather than one shared string:
a single flag can only ever represent one axis at a time, and code that
treats "anything other than the default" as "my own alternate behavior
is on" has no way to tell *which* alternate behavior a caller meant.
Two flags, two distinct questions, make that ambiguity impossible
rather than merely avoided by convention.

`bundle` folds both axes into every filename independently, in the same
orthogonal way — so a preview compile never silently overwrites the
plain deliverable on disk, whatever `variant` happens to be at the same
time, and a compile using both is simply both suffixes, in order.

#m.chapter-nav(
  prev: ("/contexture/bundle/", "satellite and bundle"),
  next: ("/contexture/diagnostics/", "Diagnostics: diagnose, set-strict"),
)
