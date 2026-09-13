#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Quickstart: a manuscript with a generated companion])
#metadata((title: "Quickstart: a manuscript with a generated companion", translation_key: "contexture-quickstart")) <website-metadata>

#title()

= Installing and compiling

```typ
#import "@preview/contexture:0.1.0": *
```

Producing more than one document from a single file needs Typst's
bundle export:

```sh
typst compile --features bundle --format bundle main.typ
```

Every project built on `contexture` can also be compiled with two
extra flags, explained in full in
#link("/contexture/variant-preview/")[Two independent compile axes]
below:

```sh
typst compile --features bundle --format bundle --input variant=... main.typ
typst compile --features bundle --format bundle --input preview=true main.typ
```

= A manuscript with a generated companion

The simplest thing to build on `contexture`: a manuscript, plus a
second document generated from it. Below, a two-function glossary —
`term()` marks where a term is first defined; `render-glossary()` lists
every term found anywhere in the bundle, each with the real page it
landed on. Neither function is part of `contexture` — this *is* what a
package built on it looks like, complete:

#m.snippet("/packages/contexture/docs/manual-snippets/bundle-glossary-basics.typ")

Compiling this exact file — `bundle-glossary-basics.typ`, the one shown
above, nothing else — with
`typst compile --features bundle --format bundle` produces two PDFs.
The first is `manuscript.pdf`:

#m.screenshot("/packages/contexture/docs/manual-snippets/bundle-glossary-basics/manuscript-plain.png")

That name has nothing to do with the file just compiled, which could be
called anything (`main.typ`, `report.typ`, ...) — it comes entirely
from `bundle()`'s own `manuscript-name:` parameter, `"manuscript"` by
default. More on this in
#link("/contexture/bundle/")[satellite and bundle] below.

`glossary.pdf`, from the very same compile:

#m.screenshot("/packages/contexture/docs/manual-snippets/bundle-glossary-basics/glossary-plain.png", width: 55%)

Three things are happening, and the rest of this manual is one chapter
per thing:

+ `term()` calls `anchor("demo-term", ...)` — drops a small, named
  piece of data at this exact spot, then renders `body` as usual.
  Covered next, in #link("/contexture/anchors/")[The anchor primitive].
+ `render-glossary()` calls `anchors("demo-term")` — every anchor of
  that kind, anywhere in the bundle, each with a real `location()` to
  read a page number off. Same chapter.
+ `satellite("glossary", ...)` describes the second document;
  `#show: bundle.with(documents: (glossary,))` is what actually
  produces both PDFs from one compile. Covered in
  #link("/contexture/bundle/")[satellite and bundle].

If what brought you here is specifically the `variant`/`preview`
flags, skip ahead — they get their own chapter, with a dedicated
example, further down.

This same shape — an anchor at each interesting spot, a satellite that
queries them — covers more than a glossary: a list of figures or
tables (the next worked example), an index of defined terms, an answer
key kept apart from the exam it belongs to, an executive summary that
cites the real page of whatever it's summarizing, supplementary
material that cites "as shown in Figure 3, p. 7" of a document
compiled in the very same pass. Nothing app-specific has to live inside
`contexture` for any of these to work — each is the same handful of
primitives, arranged differently.

#m.chapter-nav(
  prev: ("/contexture/", "contexture overview"),
  next: ("/contexture/anchors/", "The anchor primitive"),
)
