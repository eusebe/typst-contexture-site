#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Ecosystem])
#metadata((title: "Ecosystem", translation_key: "palimpsest-ecosystem")) <website-metadata>

#title()

Everything above is self-contained: palimpsest works with nothing else
installed. `letter(...)` runs on top of `contexture`, a small shared
package none of these tools ship duplicated logic for — you don't need
to know anything about it to use palimpsest as documented in this
manual.

`letter(...)` is also just a description of a document to build, which
means it combines cleanly, in the same compile, with sibling packages
built the same way:

- #link(calepin.url("/checkitoff/"))[checkitoff] — reporting-guideline
  checklists (CONSORT, PRISMA, SPIRIT, STARD, STROBE) that cite the
  manuscript's real pages.
- #link(calepin.url("/colophon/"))[colophon] — a word-count and
  figure/table audit of the composed manuscript, reading straight
  through palimpsest's own marks.

For worked examples of combining them, and an explicit list of what
works and what doesn't once two packages' marking functions might touch
the same span of text, see
#link(calepin.url("/combining/"))[Combining packages]. For the shared
mechanism underneath all of it — the anchor primitive and the compile
engine that let several packages contribute to the same compile — see
#link(calepin.url("/contexture/"))[contexture]'s own manual.

#m.chapter-nav(
  prev: ("/palimpsest/project/", "Wiring a real project"),
  next: none,
)
