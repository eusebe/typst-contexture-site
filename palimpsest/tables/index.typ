#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Working with tables])
#metadata((title: "Working with tables", translation_key: "palimpsest-tables")) <website-metadata>

#title()

`add`/`del` mark *content* — a word, a cell, a whole figure — but a
table's own shape is different: Typst's `table()` has no built-in way
to conditionally include or exclude an entire row or column depending
on the compile mode. Getting this wrong doesn't just look off — it can
leave a row that reviewers were told was added missing from the
manuscript actually submitted, or a removed row still sitting in it.

= Adding a row or column

An added row or column stays in the table in *both* compiles, exactly
like any other `#add[...]` — accepted new content never disappears
from the clean version. No `mode()` check at all: wrap each cell in
`add[...]` and include the row unconditionally, same as writing any
other table row by hand.

#m.snippet("/packages/palimpsest/docs/manual-snippets/table-row-add.typ")

Clean:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/table-row-add/result-clean.png")

Tracked:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/table-row-add/result-tracked.png")

= Removing a row or column

The opposite: a genuinely removed row or column must be *absent* from
the clean compile, and there's no native way to hide part of a table
conditionally. The fix is to build that row's cells as a spread array
that's empty in clean and populated in tracked —
`..if mode() == "clean" { () } else { (del[...], ...) }` — the same
`mode()` already used above for `require-exchange`-free examples,
exported by `lib.typ` for exactly this.

#m.snippet("/packages/palimpsest/docs/manual-snippets/table-row-remove.typ")

Clean:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/table-row-remove/result-clean.png")

Tracked:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/table-row-remove/result-tracked.png")

= Combining both in one table

A table can have an added row *and* a removed row at the same time —
the two patterns above coexist without conflict, since neither changes
`columns:`.

#m.snippet("/packages/palimpsest/docs/manual-snippets/table-row-both.typ")

Clean:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/table-row-both/result-clean.png")

Tracked:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/table-row-both/result-tracked.png")

#m.note(title: "Columns are the trap")[
  `columns:` is one fixed count for the whole table, so an added column
  and a removed column do *not* belong in the same delta: an added
  column is part of the fixed base count (present in both compiles,
  like the row case above), and only a *removed* column belongs in a
  mode-dependent addition to that count — `base + int(mode() != "clean")`
  per removed column, never per added one. Writing it the other way
  around silently drops the added column from the clean, submitted
  manuscript — easy to miss, since `manuscript-tracked.pdf` still looks
  right.
]

#m.snippet("/packages/palimpsest/docs/manual-snippets/table-column-both.typ")

Clean:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/table-column-both/result-clean.png")

Tracked:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/table-column-both/result-tracked.png")

#m.chapter-nav(
  prev: ("/palimpsest/change-list/", "change-list"),
  next: ("/palimpsest/bibliography/", "Bibliography"),
)
