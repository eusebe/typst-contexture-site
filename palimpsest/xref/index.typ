#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [xref: pointing into the manuscript])
#metadata((title: "xref: pointing into the manuscript", translation_key: "palimpsest-xref")) <website-metadata>

#title()

/ `xref(label)`: like `@label`/`ref(label)` — already correct across
  the bundle, resolving to the manuscript's real number for free — but
  with the manuscript's real page number appended.

#m.snippet("/packages/palimpsest/docs/manual-snippets/xref-basic.typ")

Manuscript, page 2:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/xref-basic/manuscript-clean-2.png")

Response:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/xref-basic/response-clean.png")

A bare `@fig-a` already gets the number right, since the letter and the
manuscript share one bundle — `xref` only adds the page. A label that
doesn't exist anywhere warns rather than breaking the compile.

#m.chapter-nav(
  prev: ("/palimpsest/pinpoint/", "pinpoint: the manuscript/letter link"),
  next: ("/palimpsest/change-list/", "change-list"),
)
