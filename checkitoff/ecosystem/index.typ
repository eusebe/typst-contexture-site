#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Ecosystem])
#metadata((title: "Ecosystem", translation_key: "checkitoff-ecosystem")) <website-metadata>

#title()

Everything above is self-contained: checkitoff works with nothing else
installed. `checklist(...)` runs on top of `contexture`, a small shared
package none of these tools ship duplicated logic for — you don't need
to know anything about it to use checkitoff as documented in this
manual. Concretely, though: `check()` is a thin wrapper around
`contexture`'s anchor primitive, and `checklist(...)` is a thin wrapper
around its shared compile pilot (`bundle`) — the same two primitives
every sibling package below is built on, alongside the `variant`/
`preview` compile-axis pair and the shared diagnostics/`strict`
mechanism.

`checklist(...)` is also just a description of a document to build,
which means it combines cleanly, in the same compile, with sibling
packages built the same way:

- #link(calepin.url("/palimpsest/"))[palimpsest] — manuscript revisions
  and a reviewer response letter that cites the manuscript's real
  pages.
- #link(calepin.url("/colophon/"))[colophon] — a word-count and
  figure/table audit of the composed manuscript.

For worked examples of combining them, and an explicit list of what
works and what doesn't once two packages' marking functions might touch
the same span of text — `check(...)` and palimpsest's `passage(...)`,
most concretely — see
#link(calepin.url("/combining/"))[Combining packages]. For the shared
mechanism underneath all of it — the anchor primitive and the compile
engine that let several packages contribute to the same compile — see
#link(calepin.url("/contexture/"))[contexture]'s own manual.

#m.chapter-nav(
  prev: ("/checkitoff/checklists/", "Built-in checklists"),
  next: none,
)
