#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Anchors: reviewer, editor, author])
#metadata((title: "Anchors: reviewer, editor, author", translation_key: "palimpsest-anchors")) <website-metadata>

#title()

The quickstart used `<r1-1>`/`<r1-2>` without explaining the shape. An
anchor is parsed into one of three kinds, purely from its shape: `<r1-2>`
is reviewer 1, comment 2; `<e1>` is editor comment 1; anything else —
`<bob-3>`, `<bob>` — is a co-author id, "bob", optionally followed by a
change number. Each kind gets its own color automatically, without any
setup:

#m.snippet("/packages/palimpsest/docs/manual-snippets/anchors-kinds.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/anchors-kinds/result-tracked.png")

Reviewers are colored by number, cycling through a fixed palette. The
editor gets one fixed color of its own. Co-authors draw from a
*separate* palette, so a reviewer and a co-author active in the same
manuscript are never confusable — and an author's color holds even
with nothing configured for them at all (Carol, above): it's a
deterministic function of the id text itself, the same color everywhere
that id appears. `set-revisions(authors: (...))`, used above for Bob
and Alice, additionally gives an id a full display name and/or a
specific color:

```typ
#set-revisions(authors: (
  bob: (name: "Bobby Fischer", color: rgb("#c026d3")),  // both
  alice: "Alice Smith",                                  // name only
))
```

Either key can be omitted; an id with a `name:` but no `color:` still
gets its automatic color, exactly like an id with nothing registered at
all.

= Multiple anchors on one passage

A comment raised jointly, or addressed in the same place —
`passage`/`added`/`deleted`/`replaced` all accept an array of anchors
instead of one:

#m.snippet("/packages/palimpsest/docs/manual-snippets/anchors-multi.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/anchors-multi/result-tracked.png")

Colored by the first anchor in the list.

= Bare anchors

`<bob>`, with no trailing `-<n>`, is deliberately *not* meant to key
into one particular exchange — it's the shape for a project with no
response document at all, where an anchor just says whose change this
is:

#m.snippet("/packages/palimpsest/docs/manual-snippets/anchors-bare.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/anchors-bare/result-tracked.png")

Reused as many times as needed, with neither of the two diagnostics
that would otherwise apply: no "duplicate exchange" (there's nothing to
be a duplicate *of* — a bare anchor isn't meant to be unique), and no
"no matching exchange" (covered next).

= require-exchange

A *numbered* anchor is assumed to answer one specific comment, so
`passage`/`added`/`deleted`/`replaced` check that a matching
`exchange`/`note` exists somewhere and warn if not:

#m.snippet("/packages/palimpsest/docs/manual-snippets/anchors-require-exchange.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/anchors-require-exchange/result-tracked.png")

`set-revisions(require-exchange: false)` turns this check off from that
point on — for a project that wants numbered, colored anchors without
ever writing a response document.

#m.chapter-nav(
  prev: ("/palimpsest/marking/", "Marking changes"),
  next: ("/palimpsest/styling/", "Styling marks: set-revisions"),
)
