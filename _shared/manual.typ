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

// Two or more screenshots side by side — `grid` is dropped by HTML
// export the same way `line`/`v` are (see `chapter-nav` above), so
// this uses a borderless table instead, same as there.
#let side-by-side(..shots) = table(
  columns: shots.pos().len(),
  stroke: none,
  inset: (x: 6pt, y: 0pt),
  ..shots,
)

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
  if prev != none [#sym.arrow.l #link(calepin.url(prev.at(0)))[#prev.at(1)]] else [],
  if next != none [#link(calepin.url(next.at(0)))[#next.at(1)] #sym.arrow.r] else [],
)

// An ecosystem mark, live rather than baked into the page as a raster/
// data-URI image: `image()` would embed it as a fixed-color
// `<img src="data:...">`, which can never react to the site's own
// dark-mode toggle. A raw `<img data-inline-svg="1">` instead gets
// swapped for the real inline <svg> at runtime by the theme's own
// site.js (the same mechanism the header's own `logo:` config already
// relies on) — which is what lets the dark-mode rule baked into each
// file by contexture-ecosystem/sync-logos.sh actually fire. `html.elem`
// only exists under HTML export (a plain `#import`-level `unknown
// variable: html` otherwise) — this site also renders a PDF twin of
// every page (`pdf = true` in calepin.toml), so the paged target needs
// its own, ordinary `image()` fallback; `css-height` (a CSS length
// string — the inlining swap strips the `width`/`height` HTML
// attributes but keeps `style` verbatim, so sizing has to go through
// `style:`) and `pdf-height` (a Typst length) size the two independently
// since a string and a Typst length aren't interchangeable.
#let inline-logo(name, css-height: "90pt", pdf-height: 90pt) = if calepin._is-html() {
  html.elem("img", attrs: (
    "src": calepin.url("/assets/logo-" + name + ".svg"),
    "alt": name,
    "data-inline-svg": "1",
    "style": "height: " + css-height + "; width: auto;",
  ))
} else {
  image("/assets/logo-" + name + ".svg", height: pdf-height)
}

// A package's mark, centered above its landing page's #title(). `align(
// center, ...)` is silently ignored by HTML export (unlike `table`'s own
// cell `align`, which does survive it, same reasoning as `chapter-nav`
// above), hence the one-cell table instead of a plain `align` call.
#let logo(name, css-height: "90pt", pdf-height: 90pt) = table(
  columns: (1fr,),
  align: center,
  stroke: none,
  inset: 0pt,
  inline-logo(name, css-height: css-height, pdf-height: pdf-height),
)

// A labelled aside for a caveat, a design note, or a "why" digression —
// calepin's own themed callout component (same reasoning as
// `screenshot` above: a hand-rolled `block(stroke: (left: ...))` is
// dropped entirely by HTML export).
#let note(title: "Note", body) = calepin.elements.callout(kind: "note", title: title, body)
