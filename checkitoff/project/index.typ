#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Wiring a real project])
#metadata((title: "Wiring a real project", translation_key: "checkitoff-project")) <website-metadata>

#title()

Every example so far is one file, compiled directly. A real project
instead usually keeps the manuscript's prose in its own file and wires
everything together from a small `main.typ`:

```typ
#show: contexture.bundle.with(
  template: my-manuscript-template,
  documents: (
    checklist(checklist: checklists.consort),
    // ... any other contexture-based package's satellite here too
  ),
)

#include "manuscript.typ"
```

`checklist(checklist:, grid-template: auto)` is what describes the
checklist for `contexture.bundle` to build. `checklist:` has no default,
for the same reason as `render-checklist`'s own `checklist:`
(#link("/checkitoff/diagnostics/")[Reading the grid]). `grid-template:`
(`auto` = leave it alone) is applied to the grid separately from the
manuscript's own `template:` — most journals want CONSORT's own
official table layout on the checklist page, not the manuscript's own
house style.

= Restricting a compile to fewer documents

`--input only=<comma-separated names>` restricts a single compile to
just the manuscript plus the named documents — `--input only=` with
nothing after it produces the manuscript alone, with no checklist at
all. Handy for a fast preview while drafting a long manuscript, where
rebuilding the grid every time is unwanted overhead.

= Why doesn't --input preview=true produce a checklist.pdf?

`check()`'s preview highlighting adds a small box around each checked
span, which can shift where a page breaks. A grid built from that
layout could then report page numbers that don't match the manuscript
actually being submitted — worse than not producing one at all.
`checklist.pdf` is only ever built from the one, real, plain compile.

= Does the checklist compile when the manuscript doesn't?

No. The manuscript and the checklist are two documents produced by the
very same Typst compile, so a hard error anywhere in the manuscript
aborts the whole compile, `checklist.pdf` included. A `check()`/`na()`
diagnostic never does this on its own — that's exactly what non-strict
mode is for — only a genuine error in the manuscript itself (an
undefined function, a malformed table, ...) does.

#m.chapter-nav(
  prev: ("/checkitoff/styling/", "Styling the grid"),
  next: ("/checkitoff/checklists/", "Built-in checklists"),
)
