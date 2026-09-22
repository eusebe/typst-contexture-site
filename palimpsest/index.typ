#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [palimpsest])
#metadata((title: "palimpsest", translation_key: "palimpsest")) <website-metadata>

#m.logo("palimpsest")

#title()

#m.version-note("palimpsest")

*palimpsest* turns one annotated manuscript into everything a
peer-review response needs: the clean manuscript, a tracked-changes
version showing every edit, and a response letter that cites the
manuscript's own real page and figure numbers — automatically, and
always in sync.

You mark changes once, inline, in the manuscript itself. Two
`typst compile` commands then produce all of it.

= The problem

Responding to peer review normally means maintaining four things by
hand: the revised manuscript, a version showing what changed, a letter
citing modified passages and page numbers, and the certainty that no
comment went unanswered. These drift apart the moment a last-minute fix
lands. `palimpsest` makes the second, third, and fourth of those
_derivable_ from the first.

= Key features

- *Mark once, get up to four documents.* `add`, `del`, `rep` inline in your manuscript; two compiles produce the clean and tracked-changes manuscript, plus a clean and tracked response letter.
- *Real cross-references, not copy-pasted page numbers.* `pinpoint(<anchor>)` reports the manuscript's actual, current page.
- *Quote the manuscript verbatim in the letter.* `pinpoint(<anchor>, excerpt: true)` re-emits the real passage.
- *Reviewers, editor, and co-authors, all colored and tracked* automatically, each with their own letter section.
- *Figure/table/equation/heading numbering that survives tracking.*
- *Diagnostics*, promotable to hard compile errors with `strict: true`.

= Installation

```typ
#import "@preview/palimpsest:0.1.0": *
#import "@preview/contexture:0.1.0": bundle
```

Requires Typst 0.15 or later, specifically its `--features bundle`
export (still experimental).

= Full guide

The complete, progressive guide — a first revision round, marking
changes, anchors, styling marks, shortcuts, writing the exchanges,
pinpoint, xref, the change-list, tables, bibliography, diagnostics,
wiring a real project, and palimpsest in the contexture ecosystem —
starts at #link(calepin.url("/palimpsest/quickstart/"))[Your first revision round].

Four complete, working projects live under
#link(m.gh-tag-url("palimpsest", path: "examples"))[`examples/`]:

- #link(m.gh-tag-url("palimpsest", path: "examples/pilot"))[`pilot/`] — the smallest complete three-file project. Copy it as a starting point. (⇒ pdf: #link(m.gh-tag-url("palimpsest", path: "examples/pilot/main/manuscript.pdf", kind: "blob"))[manuscript], #link(m.gh-tag-url("palimpsest", path: "examples/pilot/main/manuscript-tracked.pdf", kind: "blob"))[tracked], #link(m.gh-tag-url("palimpsest", path: "examples/pilot/main/response.pdf", kind: "blob"))[response], #link(m.gh-tag-url("palimpsest", path: "examples/pilot/main/response-tracked.pdf", kind: "blob"))[response-tracked])
- #link(m.gh-tag-url("palimpsest", path: "examples/fridge-study"))[`fridge-study/`] (⇒ pdf: #link(m.gh-tag-url("palimpsest", path: "examples/fridge-study/main/manuscript.pdf", kind: "blob"))[manuscript], #link(m.gh-tag-url("palimpsest", path: "examples/fridge-study/main/manuscript-tracked.pdf", kind: "blob"))[tracked], #link(m.gh-tag-url("palimpsest", path: "examples/fridge-study/main/response.pdf", kind: "blob"))[response], #link(m.gh-tag-url("palimpsest", path: "examples/fridge-study/main/response-tracked.pdf", kind: "blob"))[response-tracked]) and #link(m.gh-tag-url("palimpsest", path: "examples/emoji-email"))[`emoji-email/`] (⇒ pdf: #link(m.gh-tag-url("palimpsest", path: "examples/emoji-email/main/manuscript.pdf", kind: "blob"))[manuscript], #link(m.gh-tag-url("palimpsest", path: "examples/emoji-email/main/manuscript-tracked.pdf", kind: "blob"))[tracked], #link(m.gh-tag-url("palimpsest", path: "examples/emoji-email/main/response.pdf", kind: "blob"))[response], #link(m.gh-tag-url("palimpsest", path: "examples/emoji-email/main/response-tracked.pdf", kind: "blob"))[response-tracked]) — two full, deliberately over-the-top mock studies (multi-page manuscripts built on real Typst Universe templates, `@preview/unequivocal-ams` and `@preview/charged-ieee`, with real figures via `@preview/lilaq`) exercising essentially every feature at once: two reviewers and an editor, co-authors leaving their own notes alongside them, `change-list()`, `pinpoint` both as a page reference and as a verbatim excerpt, cross-references, and a letter-only bibliography.
- #link(m.gh-tag-url("palimpsest", path: "examples/coauthors-simple"))[`coauthors-simple/`] (⇒ pdf: #link(m.gh-tag-url("palimpsest", path: "examples/coauthors-simple/manuscript.pdf", kind: "blob"))[manuscript], #link(m.gh-tag-url("palimpsest", path: "examples/coauthors-simple/manuscript-tracked.pdf", kind: "blob"))[tracked]) — the no-reviewer, no-letter, no-bundle shape: just `add`/`del`/`change-list` in a single file, for co-authors tracking their own edits with nothing else attached.

= Combining with other packages

`palimpsest`'s `letter(...)` is just a description of a document to
build — it combines cleanly with #link(calepin.url("/checkitoff/"))[checkitoff]'s
`checklist(...)` and #link(calepin.url("/colophon/"))[colophon]'s `report(...)` in
the same compile. See #link(calepin.url("/combining/"))[Combining packages].
