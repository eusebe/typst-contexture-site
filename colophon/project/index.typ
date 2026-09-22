#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Wiring a real project])
#metadata((title: "Wiring a real project", translation_key: "colophon-project")) <website-metadata>

#title()

/ `instrument(template: body => body)`: wraps a manuscript `template:`
  — the one wrapping step colophon asks for, covered already in
  #link(calepin.url("/colophon/quickstart/"))[Quickstart]. Captures the manuscript's
  pre-layout body for the word count, and brackets the real, rendered
  output so every `query()` `report()` runs (page count, the figure
  inventory, orphan labels) stays scoped to just the manuscript
  document — without this, a query from `audit.pdf`'s own document
  would also match its own content, once it renders any heading or
  paragraph of its own to display its results.
/ `report(name: "audit", title: auto, level: 1, count-captions: false, wpm: 220, bib: none)`:
  describes the audit document — list this under `documents:` in
  `#show: contexture.bundle.with(...)`, alongside `instrument()`
  wrapping that same call's `template:`. `level:`/`count-captions:`
  are passed straight through to
  #link(calepin.url("/colophon/word-counts/"))[word-counts-by-section]; `wpm:`
  controls the reading-time estimate; `bib:` turns on the
  #link(calepin.url("/colophon/anomalies/"))[uncited-references] section.

A genuinely real manuscript, not a toy — the same full-length fake
article #link(calepin.url("/palimpsest/"))[palimpsest] uses for its own examples,
against a real Typst Universe template
(#link("https://typst.app/universe/package/unequivocal-ams")[`@preview/unequivocal-ams`]),
with real figures, a table, an equation, and palimpsest's own reviewer
letter produced alongside it:

```typ
#show: contexture.bundle.with(
  template: colophon.instrument(template: ams-article.with(
    title: [Association between fridge opening frequency and probability
    of finding something new inside],
    authors: (...),
    abstract: colophon.abstract([
      Background: repeated refrigerator-door-opening behavior
      ("fridge-checking") is common, but its relationship to the
      subjective probability of discovering something new inside
      remains uncharacterized. ...
    ]),
    bibliography: bibliography("manuscript.bib"),
  )),
  documents: (
    letter(exchanges: include "responses.typ", template: letter-template),
    colophon.report(bib: "/manuscript.bib"),
  ),
)

#include "manuscript.typ"
```

`audit.pdf`, from the same compile — six pages, a real abstract counted
separately, five figures and tables each with the template's own real
numbering, and one genuine oversight this run of colophon actually
caught: an equation, labelled but never referenced anywhere in the
prose:

#m.screenshot("/packages/colophon/docs/manual-snippets/project-example/audit-plain.png")

The complete, working project —
#link(m.gh-tag-url("colophon", path: "examples/fridge-study"))[`examples/fridge-study/`]
— lives in the repository, alongside a second one,
#link(m.gh-tag-url("colophon", path: "examples/emoji-email"))[`emoji-email/`],
against `@preview/charged-ieee`'s two-column layout instead.

= applicable: only the one, real, plain compile

Like #link(calepin.url("/checkitoff/project/"))[checkitoff's `checklist(...)`], `report()`
is only ever built from the single, real, plain compile —
`applicable: () => contexture.variant() == "plain" and not contexture.preview()`.
A `preview`/non-`"plain"`-`variant` overlay from
another `contexture`-based package sharing the same bundle can shift
page breaks, so a report built from either could cite a page count
that doesn't match the manuscript actually being submitted.

= Restricting a compile to fewer documents

`--input only=<comma-separated satellite names>` — `contexture.bundle`'s
own mechanism, not specific to colophon — restricts a single compile to
the manuscript plus just the named satellites. `--input only=` with
nothing after it produces the manuscript alone, whatever `documents:`
lists; naming `audit` explicitly (`--input only=audit`) skips any other
satellite listed alongside it for one fast run.

#m.chapter-nav(
  prev: ("/colophon/anomalies/", "Anomalies"),
  next: ("/colophon/ecosystem/", "Ecosystem"),
)
