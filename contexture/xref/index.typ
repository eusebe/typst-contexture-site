#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [xref])
#metadata((title: "xref", translation_key: "contexture-xref")) <website-metadata>

#title()

`xref(label)` behaves like `@label`/`ref(label)` — which already
resolves across documents in a bundle, a satellite's own `@tab-results`
renders the manuscript's real "Table 3" — but appends the real page
number: "Table 3, p. 14". Explicit rather than a bare `@label`, so it
stays correct even if a future document duplicates the same label,
where a bare `ref` would become ambiguous between the two copies. It
operates on plain Typst labels (figures, headings, equations, ...), not
on `contexture.anchor()` — a separate, narrower tool for the common
case where a real Typst label already exists and only the page number
needs adding.

The example in the previous chapter, #link(calepin.url("/contexture/diagnostics/"))[Diagnostics],
already shows it in use: `xref`'s own broken-reference case is exactly
what demonstrates `diagnose(..., always: true)` there.

#m.chapter-nav(
  prev: ("/contexture/diagnostics/", "Diagnostics"),
  next: ("/contexture/composing/", "Composing independent packages"),
)
