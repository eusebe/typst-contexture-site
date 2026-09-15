#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [The page-break idiom])
#metadata((title: "The page-break idiom", translation_key: "checkitoff-page-breaks")) <website-metadata>

#title()

Checkitoff doesn't try to detect a passage that straddles a page break
automatically — there's no reliable way to tell "one logical passage
split across pages" apart from "two genuinely separate mentions of the
same item." The recommended idiom instead: call `check()` a second
time, with the *same* id, right after the break.

#m.snippet("/packages/checkitoff/docs/manual-snippets/bundle-page-break-idiom.typ")

The grid reports both pages, not a merged range and not just the first:

#m.screenshot("/packages/checkitoff/docs/manual-snippets/bundle-page-break-idiom/checklist-plain-2.png")

Two genuinely separate mentions of the same item, landing on the same
page, collapse to one page number instead — the same rule, the other
direction.

#m.chapter-nav(
  prev: ("/checkitoff/excerpts/", "Quoting the real wording"),
  next: ("/checkitoff/styling/", "Styling the grid"),
)
