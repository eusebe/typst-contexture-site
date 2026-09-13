// Shared helpers for the per-package manual chapters. Not a page itself —
// calepin only compiles files reached from calepin.toml's menus/sidebar, so
// this module is safe to import without producing a stray page of its own.

#import "/.calepin/calepin.typ" as calepin

// Every ```sh/```typ block in these chapters is a static, illustrative
// snippet, never something calepin should actually execute as a
// notebook chunk (which needs jupyter_client and isn't installed here
// anyway) — importing this module turns that off for the page that
// imports it.
#calepin.setup(fenced-chunks: false)

// A real compiled screenshot. Typst's own `block(stroke:, radius:, ...)`
// is silently dropped by calepin's HTML export (no warning — the block
// itself renders, just none of its decoration), so the border has to
// come from calepin's own `elements.card`, which emits real CSS
// (`border`/`box-shadow`, using the theme's own color tokens so it
// reads correctly in both light and dark) instead of a Typst-layout
// stroke that only works in the PDF target.
#let screenshot(path, caption: none, width: 100%) = block(width: width)[
  #calepin.elements.card(width: 100%)[#image(path, width: 100%)]
  #if caption != none [
    #text(size: 0.85em, style: "italic")[#caption]
  ]
]

// The exact contents of a real, tested snippet file, read straight off
// disk — never retyped — so the code shown always matches what was
// actually compiled to produce the screenshots next to it.
#let snippet(path) = raw(read(path), block: true, lang: "typ")

// A short bottom-of-chapter nav strip: link back to the package's own
// manual overview and forward to the next chapter. `grid`/`line`/`v`
// are all layout primitives Typst's HTML export silently drops, so
// this uses a plain borderless table instead — the one layout element
// that does survive HTML export as a real element.
#let chapter-nav(prev: none, next: none) = table(
  columns: (1fr, 1fr),
  align: (left, right),
  stroke: none,
  inset: (x: 0pt, y: 8pt),
  if prev != none [#sym.arrow.l #link(prev.at(0))[#prev.at(1)]] else [],
  if next != none [#link(next.at(0))[#next.at(1)] #sym.arrow.r] else [],
)

// A labelled aside for a caveat, a design note, or a "why" digression —
// calepin's own themed callout component (same reasoning as
// `screenshot` above: a hand-rolled `block(stroke: (left: ...))` is
// dropped entirely by HTML export).
#let note(title: "Note", body) = calepin.elements.callout(kind: "note", title: title, body)
