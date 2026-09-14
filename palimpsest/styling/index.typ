#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Styling marks: set-revisions])
#metadata((title: "Styling marks: set-revisions", translation_key: "palimpsest-styling")) <website-metadata>

#title()

Call `set-revisions` once, before any `passage`, to change how tracked
marks look. Takes effect for everything *after* the call — a document
can use different styles in different sections.

```typ
#set-revisions(
  style: "inline",           // "inline" | "bar" | "none"
  color: auto,                // auto, or a fixed color for every mark
  add-style: underline,       // body -> content
  del-style: (smart default), // body -> content
  highlight-passage: false,   // tint the whole passage's background
  show-anchor: true,          // show [R1-2] at the end of the passage
  del-numbering: "none",      // "none" | "keep"
)
```

= style

#m.snippet("/packages/palimpsest/docs/manual-snippets/style-values.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/style-values/result-tracked.png")

`"inline"` (the default) underlines additions and strikes deletions in
the flow of text. `"bar"` keeps that same underline/strike on the marks
themselves and adds a colored vertical bar to the left of the whole
passage's block — best when a passage forms its own block, not text
mid-paragraph. `"none"` turns underline/strike off entirely, rendering
exactly like the clean version even in the tracked compile — a layout
sanity check, to confirm marking hasn't shifted anything.

= color

#m.snippet("/packages/palimpsest/docs/manual-snippets/style-color.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/style-color/result-tracked.png")

`auto` (the default) colors each mark by its anchor — one color per
reviewer, a separate palette per co-author, as introduced in the
previous chapter. A fixed color — `rgb(...)`, a named color — overrides
that entirely: every mark gets the same color, regardless of anchor.

= add-style / del-style

#m.snippet("/packages/palimpsest/docs/manual-snippets/style-add-del-style.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/style-add-del-style/result-tracked.png")

Both take a single `body -> content` function — *not* `(body, color)`:
the color is applied afterward, wrapped around whatever this function
returns, so a custom style only needs to decide the visual treatment
(box, highlight, ...), never the color itself.

`add-style`'s default is plain `underline`. `del-style`'s default is
smarter, because `strike()` never decorates a real math glyph or a
figure's drawing — only literal text: ordinary text still gets struck,
but a *block* equation, a figure, or a table gets a diagonal cross
instead (figures/tables also keep their caption struck natively, since
a caption is real text), and an *inline* equation gets a line straight
through it rather than a full cross. A custom function passed here
always replaces this default outright for every kind of content, the
same way it would replace plain `strike`.

Deletions are also automatically desaturated relative to additions — a
muted, darker version of the same reviewer's color, not merely "the
same color with a different decoration". This matters specifically
because the strike/cross/line above is the *only* other signal on math
or on a figure's drawing: without a color difference, an added and a
removed equation would otherwise look identical at a glance. This
isn't a `del-style` option — it always applies, on top of whatever
`del-style` renders.

= highlight-passage

#m.snippet("/packages/palimpsest/docs/manual-snippets/style-highlight-passage.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/style-highlight-passage/result-tracked.png")

`false` (the default) tints only the marks themselves — a passage where
one word changed doesn't light up entirely. `true` tints the whole
passage's background lightly, useful when a reviewer asked for a full
rewrite and marking only the changed words would understate how much
moved.

= show-anchor

#m.snippet("/packages/palimpsest/docs/manual-snippets/style-show-anchor.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/style-show-anchor/result-tracked.png")

The `[R1-2]` superscript at the end of a marked passage — what
reviewers use most in practice to find their own comment in the
manuscript without cross-referencing the letter. `false` removes the
tag; the passage is still colored.

= del-numbering

A figure, table, equation, or heading that gets deleted still exists as
a real element in the tracked manuscript — and by default would still
consume a number, shifting every one of its kind that comes after it
out of sync with the clean version. `del-numbering: "none"` (the
default) keeps the deleted element's own real number visible, struck
through, but resets the count right after it, so the *next* real one of
that kind keeps the same number in both versions:

#m.snippet("/packages/palimpsest/docs/manual-snippets/style-del-numbering-none.typ")

Tracked:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/style-del-numbering-none/result-tracked.png")

The *clean* compile of that same source, for comparison — the numbers
match:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/style-del-numbering-none/result-clean.png")

`"keep"` lets a deleted element consume a number like anything else —
rarely what you want (the whole point of `del-numbering: "none"` above
is that a reviewer reading the tracked manuscript and citing "Figure 3"
is citing the same Figure 3 that exists in the clean version you
submit), but available:

#m.snippet("/packages/palimpsest/docs/manual-snippets/style-del-numbering-keep.typ")

Tracked:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/style-del-numbering-keep/result-tracked.png")

The *clean* compile of that same source — watch the third and fifth
figures' numbers diverge from the tracked version above:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/style-del-numbering-keep/result-clean.png")

Both examples also include a table, an equation, and a heading, deleted
the same way, worth looking at closely: the table's cells and caption
are struck through, same as ordinary text, and its diagonal cross
covers the drawing itself. The equation gets the same diagonal cross
rather than a strikethrough (see `del-style` above for why), and the
heading is struck like any other text. All three keep their own number
visible, frozen under `del-numbering: "none"` so whatever comes after
them stays in sync with the clean version, or consume a real number
under `"keep"`, exactly the same freeze/consume distinction shown above
for figures.

This works the same way under a template that recomputes its own
figure or table numbers via a custom show rule — `@preview/charged-ieee`,
for instance — since the underlying counter it reads is the same one
being frozen here.

#m.chapter-nav(
  prev: ("/palimpsest/anchors/", "Anchors"),
  next: ("/palimpsest/shortcuts/", "Shortcuts"),
)
