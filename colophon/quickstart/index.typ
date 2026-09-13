#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Quickstart: your first audit])
#metadata((title: "Quickstart: your first audit", translation_key: "colophon-quickstart")) <website-metadata>

#title()

= Installing and compiling

```typ
#import "@preview/colophon:0.1.0": *
#import "@preview/contexture:0.1.0": bundle
```

Unlike #link("/palimpsest/")[palimpsest] and #link("/equator/")[equator],
colophon asks for no per-passage markup at all — no `check()`, no
`passage()`. The one thing it does need is a small wrapping step on
the manuscript's own `template:`, so it can find the manuscript's real
page span and, for the word count, its content *before* layout —
where a citation is still a real, ignorable `ref`/`cite` node rather
than the rendered bracket-and-number text citation resolution rewrites
it into:

```typ
#show: contexture.bundle.with(
  template: instrument(template: my-journal-template),
  documents: (report(),),
)

#include "manuscript.typ"
```

```sh
typst compile --features bundle --format bundle main.typ
```

produces `manuscript.pdf` — completely unaffected, since nothing here
touches the manuscript's own rendering — and `audit.pdf`, the report.

= A first, complete example

A short manuscript, two sections, one figure, one citation:

#m.snippet("/packages/colophon/docs/manual-snippets/quickstart-basics.typ")

`manuscript.pdf` — ordinary prose, with no visible trace of
`instrument()` or `report()` at all:

#m.screenshot("/packages/colophon/docs/manual-snippets/quickstart-basics/manuscript-plain.png")

`audit.pdf`, from the very same compile:

#m.screenshot("/packages/colophon/docs/manual-snippets/quickstart-basics/audit-plain.png")

Three things are already visible in that report, and the rest of this
manual is one chapter per thing:

+ *Total word count, reading time, page count* — computed from the
  manuscript actually composed, not guessed from source text. Notice
  the citation `@smith2020` contributed nothing to the count. Covered
  next, in #link("/colophon/word-counts/")[Word counts].
+ *A figure/table inventory*, with the real, resolved number and page
  — here just "Figure 1", but the same mechanism holds under a
  template with its own exotic numbering scheme. Covered in
  #link("/colophon/inventory/")[Figure and table inventory].
+ No anomalies to report here — every label this manuscript defines is
  either referenced or has none to begin with, and its one citation is
  used. What that section looks like with something to actually flag
  is #link("/colophon/anomalies/")[its own chapter].

#m.chapter-nav(
  prev: ("/colophon/", "colophon overview"),
  next: ("/colophon/word-counts/", "Word counts"),
)
