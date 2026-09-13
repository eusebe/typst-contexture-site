// Shared helpers for the per-package manual chapters. Not a page itself —
// calepin only compiles files reached from calepin.toml's menus/sidebar, so
// this module is safe to import without producing a stray page of its own.

// A real compiled screenshot, in a thin neutral border that reads fine in
// both light and dark themes (no fill: the screenshot's own white page
// already provides the contrast).
#let screenshot(path, caption: none, width: 100%) = block(width: width)[
  #block(
    stroke: 0.5pt + luma(180),
    inset: 3pt,
    radius: 4pt,
    width: 100%,
    image(path, width: 100%),
  )
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
// visually distinct from the main prose without hardcoding light/dark
// colors that would fight the site's own theme.
#let note(title: "Note", body) = block(
  stroke: (left: 2pt + luma(150)),
  inset: (left: 10pt, y: 2pt),
  width: 100%,
)[
  #text(weight: "bold", size: 0.9em)[#title] \
  #body
]
