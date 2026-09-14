#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [change-list])
#metadata((title: "change-list", translation_key: "palimpsest-change-list")) <website-metadata>

#title()

/ `change-list(title: [Summary of changes], level: 1)`: one row per
  marked passage — comment, type of change, page, section.

#m.snippet("/packages/palimpsest/docs/manual-snippets/change-list-basic.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/change-list-basic/result-tracked.png")

Renders nothing in clean mode, like `del`/`suppress` — placed once
anywhere in shared manuscript content, it only ever shows up in
`manuscript-tracked.pdf`. Rows are sorted by comment identifier —
reviewers in order, then co-authors alphabetically by id, then the
editor, anchor-less passages last — so the table doubles as a checklist
against the letter, not just a readout of document order. `touched`
never appears: nothing changed there to list. A passage with several
marks shows every kind it contains, joined with "/"
(`addition/deletion`, say, for a manually mixed passage that isn't a
single `rep`).

The "Section" column is the nearest preceding heading at `level:`
(top-level by default) — notice the reviewer comment inside
"Background" above is listed under "Introduction", its enclosing
top-level section, not the subsection itself.

= level: — which heading counts as "Section"

#m.snippet("/packages/palimpsest/docs/manual-snippets/change-list-level.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/change-list-level/result-tracked.png")

Same passage, same position — only `level:` differs between the two
calls, and the Section column changes with it: `1` (the default) names
the enclosing top-level heading, `2` the enclosing subsection.

= title: — avoiding a redundant heading

`change-list()` prints its own bold "Summary of changes" line above the
table by default. If you already write your own heading right before
the call, that becomes two headings back to back:

#m.snippet("/packages/palimpsest/docs/manual-snippets/change-list-title.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/change-list-title/result-tracked.png")

`title: none` removes the package's own line, leaving just your heading
and the table — `title: [Some other text]` would replace it with
different wording instead, for the same reason.

#m.chapter-nav(
  prev: ("/palimpsest/xref/", "xref"),
  next: ("/palimpsest/tables/", "Working with tables"),
)
