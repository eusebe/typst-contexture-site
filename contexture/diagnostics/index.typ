#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Diagnostics])
#metadata((title: "Diagnostics", translation_key: "contexture-diagnostics")) <website-metadata>

#title()

Typst has no public API to emit a soft compiler warning from user code,
so the closest available approximation is a visible marker rendered
directly at the fault location, which most Typst editors preview live.

/ `diagnose(message, always: false)`: reports a problem at the call
  site. Under `set-strict(true)`, always a hard `panic` — a real
  compile error, in any mode. Otherwise, a visible inline marker —
  muted specifically when `variant() == "plain"` and `preview()` is
  off (`always: false`, the default), since that's the file most
  likely to leave this codebase and reach someone who never asked to
  see an internal warning; shown unconditionally when `always: true`,
  for a diagnostic embedded in a document that is *never* itself the
  deliverable (a generated report, an internal checklist) where muting
  it would mean it's never seen at all.
/ `set-strict(v)`: turns every `diagnose(...)` call, anywhere in the
  bundle, into a hard error at once — one shared CI gate rather than a
  check per document. Normally set via `bundle(strict: true, ...)`, not
  called directly.

`xref` (#link("/contexture/xref/")[below]) always passes
`always: true` — a broken cross-reference should never be silently
invisible even in the real, submitted deliverable:

#m.snippet("/packages/contexture/docs/manual-snippets/xref-basic.typ")

#m.screenshot("/packages/contexture/docs/manual-snippets/xref-basic/result-plain.png")

#m.chapter-nav(
  prev: ("/contexture/variant-preview/", "Two independent compile axes"),
  next: ("/contexture/xref/", "xref"),
)
