#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [List of figures])
#metadata((title: "List of figures", translation_key: "contexture-list-of-figures")) <website-metadata>

#title()

The glossary above makes the mechanism easy to follow, at the cost of
being a little toy — two terms, one line each. Here's a version closer
to what you'd actually paste into a real project: a "List of Figures"
companion, several entries deep, spanning a page break, each citing the
real page its figure landed on.

#m.snippet("/packages/contexture/docs/manual-snippets/bundle-list-of-figures.typ")

`manuscript.pdf` — three ordinary figures across two pages, nothing
about them different from any other Typst document:

#m.side-by-side(
  m.screenshot("/packages/contexture/docs/manual-snippets/bundle-list-of-figures/manuscript-plain-1.png", caption: [page 1]),
  m.screenshot("/packages/contexture/docs/manual-snippets/bundle-list-of-figures/manuscript-plain-2.png", caption: [page 2]),
)

`list-of-figures.pdf`, from the same compile:

#m.screenshot("/packages/contexture/docs/manual-snippets/bundle-list-of-figures/list-of-figures-plain.png", width: 70%)

`fig()` numbers its own entries by the order `anchor()` calls arrive
in, rather than reading Typst's built-in `counter(figure)` — simpler,
and exactly right as long as `fig()` is the only thing creating figures
in the document (a project mixing `fig()` with bare `figure()` calls
would want `counter(figure).at(hit.location())` instead, the same
real-counter trick `strip-labels` uses above). Either way, the page
numbers are never guessed or hand-typed — they come from
`location().page()` on the anchor Typst itself placed, in the very
compile that produced `manuscript.pdf`.

#m.chapter-nav(
  prev: ("/contexture/anchors/", "The anchor primitive"),
  next: ("/contexture/bundle/", "satellite and bundle"),
)
