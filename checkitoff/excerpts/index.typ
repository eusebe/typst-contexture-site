#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Quoting the real wording])
#metadata((title: "Quoting the real wording", translation_key: "checkitoff-excerpts")) <website-metadata>

#title()

`excerpt-of(id, quotes: false, show-page: false, on-empty: none)`
re-emits the exact content `check()` anchored to `id` — one block per
occurrence, so an item checked in two places yields two excerpts. It
isn't part of the official grid, which only ever has a page-number
column; it's for a supplementary appendix some journals or protocols
additionally want, with the exact wording quoted next to each item, or
for an internal compliance review.

#m.snippet("/packages/checkitoff/docs/manual-snippets/bundle-excerpt.typ")

#m.screenshot("/packages/checkitoff/docs/manual-snippets/bundle-excerpt/manuscript-plain.png")

`quotes: true` wraps a textual excerpt in real quotation marks, and
silently declines on anything that isn't text — a figure, a table, a
block equation. `on-empty` (nothing, by default) is deliberately *not* a
diagnostic the way an uncovered item is in the grid: this function can
be called from inside the manuscript itself, where nothing should ever
render a warning box in the real, submitted deliverable — an uncovered
item is already flagged exactly once, safely, in `checklist.pdf`.

#m.chapter-nav(
  prev: ("/checkitoff/diagnostics/", "Reading the grid"),
  next: ("/checkitoff/page-breaks/", "The page-break idiom"),
)
