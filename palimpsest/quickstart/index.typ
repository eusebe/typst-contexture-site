#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Your first revision round])
#metadata((title: "Your first revision round", translation_key: "palimpsest-quickstart")) <website-metadata>

#title()

= Installing and compiling

```typ
#import "@preview/palimpsest:0.1.0": *
#import "@preview/contexture:0.1.0": bundle
```

A full project (manuscript, tracked manuscript, response letter)
compiles with two commands:

```sh
typst compile --features bundle --format bundle main.typ
typst compile --features bundle --format bundle --input variant=tracked main.typ
```

The first produces `manuscript.pdf` and, once there are responses to
answer, `response.pdf`; the second produces `manuscript-tracked.pdf`
and, under the same condition, `response-tracked.pdf`. Marking
functions — `add`, `del`, `rep`, `passage`, `set-revisions` — also work
directly in a single ordinary file, with a plain `typst compile` /
`typst compile --input variant=tracked`, no bundle involved — that's
the form used throughout the next few chapters.

Palimpsest itself never calls Typst's own `document(...)` — that job
belongs to `contexture`, the shared engine imported alongside it above.
Nothing about that needs to be understood to use the functions in the
chapters below; it only becomes relevant once a real, multi-file
project gets wired together, in
#link(calepin.url("/palimpsest/project/"))[Wiring a real project] further down.

#m.note(title: "About the examples in this manual")[
  Every example here is a single, self-contained file, compiled
  directly — the simplest way to show what each function does on its
  own. A real project instead keeps the manuscript, the exchanges, and
  the wiring in their own files; that shape is introduced once you've
  met the pieces it's built from.
]

= A first, complete example

The smallest complete example: one reviewer, two comments, one
accepted change and one declined — the whole manuscript/letter pair
produced from a single file.

#m.snippet("/packages/palimpsest/docs/manual-snippets/quickstart-first-round.typ")

A few things to notice, top to bottom:

+ `letter(exchanges: [...], template: ...)` describes the response
  letter; `#show: contexture.bundle.with(documents: (letter(...),))` is
  the one line of setup a real project needs — everything else is the
  manuscript and the exchanges, written exactly as prose.
+ `<r1-1>` and `<r1-2>` are *anchors* — a reviewer number and a comment
  number, packed into a label. `#exchange(<r1-1>)[comment][response]`
  writes reviewer 1's first comment and the reply to it; `#added(<r1-1>)[...]`
  in the manuscript ties the actual change to that same comment. The
  full anchor syntax — editor comments, co-author ids, anchors with no
  response document at all — gets its own chapter next.
+ `#pinpoint(<r1-1>)`, inside the response, is what turns into "p. 1"
  below — the real page the change landed on, in this very compile.
+ `#touched(<r1-2>)[...]` marks a passage as reviewed but unchanged —
  useful whenever the honest answer to a comment is "we didn't change
  the text, see our response instead," exactly what the second exchange
  says.

Compiled plain, `manuscript.pdf` reads like ordinary prose, with no
visible trace of any anchor or reviewer:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/quickstart-first-round/manuscript-clean.png")

Compiled again with `--input variant=tracked`, the accepted change is
underlined and both passages carry a small `[R1-1]`/`[R1-2]` tag,
colored by reviewer:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/quickstart-first-round/manuscript-tracked.png")

And `response.pdf`, from the very same, plain compile — the actual
letter, citing real pages:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/quickstart-first-round/response-clean.png", width: 75%)

`response-tracked.pdf` comes out of the second compile the same way,
automatically — more on exactly when and why a letter appears at all in
#link(calepin.url("/palimpsest/project/#the-letter-automatically-matched-to-the-manuscript-you-actually-send"))[The
letter, automatically], further down.

= Recommended workflow

+ Mark each change in the manuscript as it's made — `#passage(<r1-2>)[...]`
  wrapping `#add`/`#del`/`#rep`, or `#touched(<r1-2>)[...]` where
  nothing changed but a comment still needs an anchor to point to.
+ Write the exchanges — `#reviewer(n)[...]`, `#exchange(anchor)[comment][response]`
  — quoting each comment and citing your response with `#pinpoint(anchor)`.
+ Compile twice: plain, and with `--input variant=tracked`. Check that
  `manuscript.pdf` reads as the real, final submission, and that
  `manuscript-tracked.pdf` shows every change a reviewer would expect
  to see.
+ Read `response.pdf`/`response-tracked.pdf` for diagnostics — a
  numbered anchor with no matching exchange, an exchange answering
  nothing, an empty passage.
  #link(calepin.url("/palimpsest/diagnostics/"))[Diagnostics and strict mode] covers
  every case.
+ Before submission, compile once with `strict: true` — every remaining
  diagnostic becomes a hard compile error instead of a soft marker, a
  clean pass/fail gate.
+ Submit `manuscript.pdf` (and `manuscript-tracked.pdf`, if the journal
  wants it) alongside `response.pdf` — all of it came from the same
  compile(s), so every page the letter cites is guaranteed to match.

#m.chapter-nav(
  prev: ("/palimpsest/", "palimpsest overview"),
  next: ("/palimpsest/marking/", "Marking changes"),
)
