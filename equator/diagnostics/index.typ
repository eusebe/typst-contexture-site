#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Reading the grid])
#metadata((title: "Reading the grid", translation_key: "equator-diagnostics")) <website-metadata>

#title()

`render-checklist(checklist:, title: auto)` is the function that draws
the grid you already saw in
#link("/equator/quickstart/")[Your first checklist]: every official
item, grouped by section (and, when the checklist has one, by a
mid-level group inside a section), each item's resolved page number(s),
and a Diagnostics block listing anything that doesn't add up. In an
ordinary project you never call it directly — the `checklist(...)`
satellite (#link("/equator/project/")[Wiring a real project]) calls it
for you — but it's exported on its own too, in case a project ever
needs the grid outside the usual two-document setup.

A checklist is plain data, as already seen: `name`, `full-name`,
`items`, plus optional `headers`, `style`, and `citation` fields covered
later in this manual. `checklist:` never defaults to anything, even
though CONSORT ships built in — an explicit choice costs nothing and
avoids a silent, surprising default once a project is juggling more
than one grid.

= Diagnostics

Five situations are flagged, always in the same way, so `strict:` mode
(#link("/equator/diagnostics/#strict-mode")[below]) catches every one of
them consistently:

- an item never `check()`'d or `na()`'d at all — *not covered*;
- a `check()` call whose content is blank — most often a copy-paste
  slip, where the id was moved but the text wasn't filled in;
- an id used by `check()`/`na()` that matches no item in the active
  checklist — typically a typo, or a leftover from switching checklists;
- the same id both `check()`'d and `na()`'d — a real contradiction: an
  item can't be simultaneously reported somewhere and declared not
  applicable;
- the same id `na()`'d more than once.

The first three (not covered / blank / unknown id) show up right in the
Page column, as a warning marker; every diagnostic's full sentence,
including the two that have no single cell of their own (unknown id,
duplicate `na()`), is listed underneath the table, in a dedicated
Diagnostics block.

#m.snippet("/packages/equator/docs/manual-snippets/bundle-diagnostics.typ")

#m.screenshot("/packages/equator/docs/manual-snippets/bundle-diagnostics/checklist-plain.png")

This same example also shows what happens when consecutive items share
one `topic` (t6/t7, both "Topic 4", under the "Sub-group demo" group):
the Topic cell spans both rows instead of repeating.

= Strict mode

By default, every diagnostic above is a soft, visible marker — easy to
spot while drafting, but it won't fail a build on its own. `strict:
true`, passed to `contexture.bundle(...)` (not to `checklist(...)` —
strictness is a property of the whole compile, so it covers any other
`contexture`-based package sharing it too), turns every one of them into
a hard compile error instead:

```typ
#show: contexture.bundle.with(
  strict: true,
  documents: (checklist(checklist: my-checklist),),
)

= Manuscript

// No check("s1") anywhere below --- this manuscript now
// FAILS TO COMPILE under strict: true, with a real compile
// error naming the uncovered item, instead of a soft marker
// sitting quietly in checklist.pdf.
```

The positive case — everything covered, `strict: true` compiles cleanly,
with no diagnostic anywhere:

```typ
#show: contexture.bundle.with(
  strict: true,
  documents: (checklist(checklist: my-checklist),),
)

= Manuscript

#check("s1")[This item is covered here.]
#na("s2", reason: [Not applicable to this manuscript, with a
  proper justification.])
```

A real project typically reserves `strict: true` for a CI compile or a
final pre-submission check — a hard gate — while drafting locally
without it, so an incomplete manuscript still produces a readable
`checklist.pdf` with markers instead of refusing to build at all.

#m.chapter-nav(
  prev: ("/equator/marking/", "Marking items: check and na"),
  next: ("/equator/excerpts/", "Quoting the real wording"),
)
