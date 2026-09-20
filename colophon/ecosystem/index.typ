#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Ecosystem])
#metadata((title: "Ecosystem", translation_key: "colophon-ecosystem")) <website-metadata>

#title()

Everything above is self-contained: colophon works with nothing else
installed. `report(...)` runs on top of `contexture`, a small shared
package none of these tools ship duplicated logic for — you don't need
to know anything about it to use colophon as documented in this manual.
Unlike its siblings, colophon doesn't use `contexture`'s anchor
primitive at all: it has no per-passage markup to anchor, since it
audits the composed document rather than passages an author marked —
which is also why it never needs a nesting rule when combined with
them.

`report(...)` is also just a description of a document to build, which
means it combines cleanly, in the same compile, with sibling packages
built the same way:

- #link(calepin.url("/palimpsest/"))[palimpsest] — manuscript revisions
  and a reviewer response letter that cites the manuscript's real
  pages. As #link(calepin.url("/colophon/word-counts/"))[Word counts]
  already showed, colophon reads straight through palimpsest's own
  marks when both are used together.
- #link(calepin.url("/checkitoff/"))[checkitoff] — reporting-guideline
  checklists (CONSORT, PRISMA, SPIRIT, STARD, STROBE) that cite the
  manuscript's real pages.

For a full worked example combining all three, see
#link(calepin.url("/combining/"))[Combining packages]. For the shared
mechanism underneath all of it — the compile engine that lets several
packages contribute to the same compile — see
#link(calepin.url("/contexture/"))[contexture]'s own manual.

#m.chapter-nav(
  prev: ("/colophon/project/", "Wiring a real project"),
  next: none,
)
