#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [The anchor primitive: anchor, anchors])
#metadata((title: "The anchor primitive: anchor, anchors", translation_key: "contexture-anchors")) <website-metadata>

#title()

/ `anchor(kind, payload)`: marks the current location with a
  namespaced, queryable piece of data. `kind` namespaces the anchor so
  two unrelated pieces of code picking the same `id` scheme never
  collide — prefix it with something specific to what you're building
  (`"glossary-term"`, `"figure-list-entry"`). `payload` is whatever you
  need back later — entirely opaque to `contexture` itself.
  Deliberately renders nothing on its own beyond the metadata: emitting
  it and deciding how (or whether) to render content around it are two
  different jobs, left to the caller, exactly as `term()`
  (#link("/contexture/quickstart/")[the quickstart]) does both
  explicitly.
/ `anchors(kind)`: every anchor of that kind, in document order, from
  *anywhere in the bundle* — including a document other than the one
  this is called from, which is the entire point. Must be called from
  within a `context`.

= Re-emitting stored content: strip-labels

A term's `body` can be arbitrary content, including a labelled figure —
and re-emitting that figure verbatim into the glossary would otherwise
plant a second copy of its label, which Typst rejects outright as a
duplicate. `strip-labels(node)` reconstructs `node` with every label
removed, and — specifically for a `figure`, a labelled block equation,
or a `heading` — pins the *real*, already-resolved number of the true
original onto the copy's own `numbering`, read directly via a fresh
`query()` of that label. The copy shows the same number as the
original; only the original stays a real, referenceable target.

#m.snippet("/packages/contexture/docs/manual-snippets/bundle-glossary-figure.typ")

Both the manuscript and the glossary show "Table 1" — the genuine,
resolved number, not a guess:

#m.side-by-side(
  m.screenshot("/packages/contexture/docs/manual-snippets/bundle-glossary-figure/manuscript-plain.png", caption: [manuscript.pdf]),
  m.screenshot("/packages/contexture/docs/manual-snippets/bundle-glossary-figure/glossary-plain.png", caption: [glossary.pdf]),
)

= Structural utilities

`collect-metadata(body, tag)` and `collect-labels(body)` are the
structural building blocks `strip-labels` and `anchor`/`anchors`
themselves are built from — a plain walk of an in-memory content tree,
no `context` or layout involved, exposed directly for code that needs
to inspect content it's holding but hasn't (or may never) placed into
any document this compile. `is-blank(body)` answers "does this contain
any real text at all" (handy for flagging an accidentally empty call
to something like `term()`); `is-textual(body)` answers "is this safe
to wrap in literal quotation marks", i.e. free of any `figure`,
`table`, or block equation that a stray quote mark would otherwise
float above.

#m.chapter-nav(
  prev: ("/contexture/quickstart/", "Quickstart"),
  next: ("/contexture/list-of-figures/", "A fuller example: list of figures"),
)
