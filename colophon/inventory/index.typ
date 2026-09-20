#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Figure and table inventory])
#metadata((title: "Figure and table inventory", translation_key: "colophon-inventory")) <website-metadata>

#title()

/ `figure-inventory(start, end)`: one row per figure/table found in
  the manuscript's span — item (its kind and real, resolved number),
  caption, and page. `render-report(...)` calls this for the "Figures
  and tables" section; exposed on its own for the same reason as
  #link(calepin.url("/colophon/word-counts/"))[word-counts-by-section].

Two figures, one table, and one figure with no caption at all:

#m.snippet("/packages/colophon/docs/manual-snippets/inventory-basics.typ")

#m.screenshot("/packages/colophon/docs/manual-snippets/inventory-basics/audit-plain.png")

Worth noticing: figures and tables are numbered independently ("Figure
1", "Figure 2", "Figure 3" alongside its own "Table 1", not sharing one
counter), and the unlabelled figure falls back to "--" for its caption
column rather than a blank cell.

= The real numbering, even under an exotic scheme

A labelled figure's item is rendered via `ref(label)` — *not*
reconstructed by hand from `it.counter.at(it.location())` and
`it.supplement`. That choice was found necessary, not just tidier: a
first version did reconstruct it by hand, and against a real template
with its own numbering scheme
(#link("https://typst.app/universe/package/unequivocal-ams")[`@preview/unequivocal-ams`]'s
`theorem` environment, which numbers by section — "Theorem 0.1",
"1.1", ...) two different theorems both read back the same raw counter
value, a real, silent wrong number, not merely an untidy one.
`ref(label)` sidesteps the problem entirely: it's the exact mechanism
that already prints the right, real number *inside* the manuscript
itself, however exotic the scheme, so asking it to do the same work
here is strictly more correct than re-deriving it.

#m.snippet("/packages/colophon/docs/manual-snippets/real-template.typ")

#m.screenshot("/packages/colophon/docs/manual-snippets/real-template/audit-plain.png")

#m.note(title: "A known, cosmetic gap")[
  Look closely at the two theorems above: "Theorem 1" and "Theorem
  1.11" — correctly *distinct*, which is the bug this design avoids,
  but the second one's real, in-manuscript rendering is actually
  "Theorem 1.1", not "1.11". Without the label's originating
  document's own local `show ref: ...` styling — specific to each
  document in the bundle — `ref()`'s cross-document rendering from
  `audit.pdf` can lose that formatting. The underlying number and page
  stay correct; only the exact punctuation can differ, and only for a
  template with a numbering scheme this exotic — an ordinary `Figure
  1`/`Table 1`, everything shown elsewhere in this manual, isn't
  affected.
]

An unlabelled figure has no `ref` to lean on, so it still falls back to
the manual `supplement`/`counter` reconstruction — accurate for the
common, simple case every other example in this manual uses, just not
guaranteed to hold for every possible custom scheme the way a labelled
figure's `ref(...)` is.

#m.chapter-nav(
  prev: ("/colophon/abstract/", "The abstract"),
  next: ("/colophon/anomalies/", "Anomalies"),
)
