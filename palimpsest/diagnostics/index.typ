#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Diagnostics and strict mode])
#metadata((title: "Diagnostics and strict mode", translation_key: "palimpsest-diagnostics")) <website-metadata>

#title()

Typst has no public API for a script to emit its own compiler warning,
so every check below shows instead as a visible box, right at the
fault — muted for anything embedded in the manuscript itself when the
compile is both `variant: "clean"` and not `preview: true`
(`manuscript.pdf` must never carry one, since it's the file actually
sent out under review), shown regardless of mode for anything embedded
in the letter (the letter is never sent out for blind review the way
the manuscript is, so hiding it in one mode buys nothing). This muting
logic itself lives in `@preview/contexture`, shared with every other
package built on it — see
#link("/palimpsest/project/")[Wiring a real project] below.

Two already appeared earlier, in context: a numbered anchor with
#link("/palimpsest/anchors/#require-exchange")[no matching exchange]
and a bare anchor's exemption from it; `pinpoint` with
#link("/palimpsest/pinpoint/#page-only-by-default")[no matching anchor]
(`on-empty:`). Four more:

#m.snippet("/packages/palimpsest/docs/manual-snippets/diagnostics-gallery.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/diagnostics-gallery/result-tracked.png")

Four more exist but aren't demonstrated live here, since each needs a
slightly unusual setup to trigger: two numbered exchanges sharing one
anchor (`duplicate exchange r1-2`); `xref`/`xcomment` pointing at a
label or anchor that doesn't exist anywhere (`xref(<fig-x>): not found`,
`xcomment(<r9-9>): no exchange found for this anchor`); and an excerpt
whose passage contains a label also referenced elsewhere in the bundle,
which falls back to citing the page instead of crashing the compile
outright — rare in practice, since `pinpoint(excerpt: true)` already
strips labels from what it re-emits before this check would even
trigger.

`contexture.bundle(strict: true, ...)` — the bundle's own `strict:`
parameter, see #link("/palimpsest/project/")[Wiring a real project]
below — turns every one of these into a hard compile error, in both
modes, for palimpsest *and* any other package sharing the same bundle
(equator's checklist diagnostics included, if one is listed too):

```typ
#show: contexture.bundle.with(strict: true, ...)
```

Not the default, since a manuscript mid-revision should still compile
— meant for a CI gate right before submission, when every one of these
should already be resolved.

#m.chapter-nav(
  prev: ("/palimpsest/bibliography/", "Bibliography"),
  next: ("/palimpsest/project/", "Wiring a real project"),
)
