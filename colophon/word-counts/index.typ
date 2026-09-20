#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Word counts])
#metadata((title: "Word counts", translation_key: "colophon-word-counts")) <website-metadata>

#title()

/ `word-counts-by-section(body, level: 1, count-captions: false)`: one
  row per heading at `level:` (top-level by default), the words found
  under it. `render-report(...)` calls this for you — reach for it
  directly only if a project needs the numbers outside the usual
  report layout.
/ `extract-text(node, count-captions: false)`: the structural walk
  underneath it — content in, plain text out, with every reference,
  citation, and label already stripped.
/ `count-words(s)`: splits on whitespace, nothing fancier.

Three exclusions are always in effect, none of them configurable off:

+ *Citations and cross-references.* A resolved `@smith2020` becomes a
  bracketed number once Typst lays a page out — real text, easy to
  miscount as prose. `extract-text` never sees that: it walks the
  manuscript's content *before* layout, captured by `instrument()`
  (#link(calepin.url("/colophon/quickstart/"))[Quickstart]) at the exact moment
  `contexture.bundle` hands it to `template:`, where a citation is
  still a real, ignorable `ref`/`cite` node rather than rendered text.
+ *Table cells.* A `table()`'s cells have no space/paragraph-break
  between them in the content tree the way a paragraph's words do —
  concatenating them as if they were prose merges neighbouring cells
  into nonsense tokens (`"A"`, `"B"` becoming `"AB"`, one word instead
  of two, or worse for multi-word cells). Never counted, in *any*
  mode — table data was never prose to begin with.
+ *Figure captions, by default* — `count-captions: true` opts them in,
  passed to `report(...)`.

#m.note[
  colophon reads through #link(calepin.url("/palimpsest/"))[palimpsest]'s own marks
  too — `add`/`del`/`rep`/`passage`/`touched` all render their actual
  output wrapped in a `context` block, even in clean mode, which is
  structurally invisible to colophon's pre-layout walk the same way a
  citation's rendered bracket would be. Rather than trying to see
  through that opacity, colophon reads each function's own plain,
  non-context metadata directly — the exact content clean mode shows,
  no more and no less.
]

#m.snippet("/packages/colophon/docs/manual-snippets/palimpsest-integration.typ")

The count matches exactly what the *clean*, submitted manuscript would
show: the deleted words gone, the replacement's new wording only, the
untouched passage counted normally, and — since this example passes
`count-captions: true` — the figure's own caption too:

#m.screenshot("/packages/colophon/docs/manual-snippets/palimpsest-integration/audit-plain.png")

= Table cells versus captions, side by side

The same manuscript that introduces
#link(calepin.url("/colophon/inventory/"))[the figure/table inventory] also makes
the table-cell exclusion visible: its results table holds the literal
text "A" and "B", and the total word count is unaffected by them
either way count-captions is set — worth keeping in mind when a word
count seems low for a manuscript that's mostly tables and figures:

#m.screenshot("/packages/colophon/docs/manual-snippets/inventory-basics/audit-plain.png")

#m.chapter-nav(
  prev: ("/colophon/quickstart/", "Quickstart"),
  next: ("/colophon/abstract/", "The abstract"),
)
