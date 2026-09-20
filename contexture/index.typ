#import "/.calepin/calepin.typ" as calepin

#set document(title: [contexture])
#metadata((title: "contexture", translation_key: "contexture")) <website-metadata>

#title()

*contexture* is the small, package-agnostic engine
#link(calepin.url("/palimpsest/"))[palimpsest],
#link(calepin.url("/checkitoff/"))[checkitoff], and
#link(calepin.url("/colophon/"))[colophon] are all built on: it turns
Typst's experimental bundle export into a primitive any package author
can use to produce a manuscript plus one or more companion documents
that can query each other's real, final page numbers, from a single
compile. Reading this manual isn't required to use any of those three —
it's here for whoever wants to understand *how* the ecosystem works
underneath, see the mechanism demonstrated on its own, or build a new
package on the same foundation.

You'll rarely import `contexture` for what it does on its own — it has
no notion of revisions, checklists, or word counts. You reach for it
when you're building (or combining) packages that need to produce more
than one document from one manuscript. The three packages above cover
what exists today; because the mechanism is package-agnostic, a fourth
built the same way gets it for free, with none of the first three
having to change.

= The problem

Typst's bundle export lets one compile produce several documents that
share one introspection space: a query run from any of them sees
content laid out in _all_ of them, with real, final page numbers —
because they were genuinely composed together in the same pass.
That's the primitive a glossary, an index, a list of figures, a
reviewer response letter, or a completed reporting-guideline grid all
need.

The catch: Typst's own `document(...)` — the call that actually names
one of those documents — cannot be nested inside another `document(...)`.
That rules out two independent packages each calling it on their own.
`contexture` is the fix: the _only_ place that ever calls `document(...)`.
Any package built on it instead exposes a small constructor that
returns inert data, and the author lists as many of those as they like
under one shared `documents:`.

= Key features

- *`anchor` / `anchors`* — mark a spot in one document, read it back from any other, by its real page.
- *`satellite` / `bundle`* — one shared entry point that decides which documents come out of a compile, so several independent pieces of code can each contribute a document without fighting over who owns `document(...)`.
- *`variant` / `preview`* — two small, independent flags any document built on `contexture` can read: `variant` decides _whether something is there at all_; `preview` decides _how much you can see of how it got there_.
- *`diagnose` / `set-strict`* — a shared way to flag a problem that turns into a hard compile error everywhere at once under `strict: true`.
- *`xref`* — like a bare reference, already correct across a bundle, but with the real page number appended.

= Installation

```typ
#import "@preview/contexture:0.1.0": *
```

Requires Typst 0.15 or later, specifically its `--features bundle`
export (still experimental).

= Full manual

The complete, progressive manual — a quickstart, the anchor primitive,
a fuller list-of-figures example, satellite and bundle, the two compile
axes, diagnostics, xref, and composing independent packages — starts at
#link(calepin.url("/contexture/quickstart/"))[Quickstart: a manuscript with a
generated companion]. A PDF version
(#link("https://github.com/eusebe/typst-contexture/blob/main/docs/manual.pdf")[docs/manual.pdf])
is also available in the
#link("https://github.com/eusebe/typst-contexture")[repository].

= Built on `contexture`

- #link(calepin.url("/palimpsest/"))[palimpsest] — manuscript revisions and a reviewer response letter that cites the real pages.
- #link(calepin.url("/checkitoff/"))[checkitoff] — reporting-guideline checklists filled in with the real pages.
- #link(calepin.url("/colophon/"))[colophon] — a companion audit of the composed manuscript.
