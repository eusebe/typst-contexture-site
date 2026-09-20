#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [pinpoint])
#metadata((title: "pinpoint", translation_key: "palimpsest-pinpoint")) <website-metadata>

#title()

```typ
#pinpoint(anchor, excerpt: false, parens: true, verb: auto, show-page: true, quotes: false, format: auto, mode: auto, on-empty: auto)
```

`pinpoint(<anchor>)` searches the manuscript for every passage carrying
that anchor and reports where it is — the mechanism behind the real
page numbers a response letter cites, since the manuscript and the
letter share one bundle.

= Page only, by default

#m.snippet("/packages/palimpsest/docs/manual-snippets/pinpoint-basic.typ")

Manuscript:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-basic/manuscript-clean.png")

Response:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-basic/response-clean.png")

The same anchor on two passages, on different pages, reports both:

#m.snippet("/packages/palimpsest/docs/manual-snippets/pinpoint-two-pages.typ")

Manuscript, page 1:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-two-pages/manuscript-clean-1.png")

Manuscript, page 2:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-two-pages/manuscript-clean-2.png")

Response:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-two-pages/response-clean.png")

If the anchor matches no real `add`/`del`/`rep` mark anywhere — a
`touched` passage, cited only to point at text that didn't change —
the verb switches from "modified on" to "see" automatically. Not a
style choice: asserting a change that didn't happen would simply be
false, so nothing has to be configured for it.

= parens: and verb: — fitting the citation into a sentence

The wired-in parenthetical reads fine as a trailing citation ("We
addressed this concern (modified on p. 3)."), but not every sentence
ends that way:

#m.snippet("/packages/palimpsest/docs/manual-snippets/pinpoint-parens-verb.typ")

Manuscript:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-parens-verb/manuscript-clean.png")

Response:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-parens-verb/response-clean.png")

`parens: false` drops the parentheses; `verb: none` additionally drops
"modified on"/"see", leaving only "p. 3" (or "p. 3 and p. 7" for two
pages) — for a sentence, like `See #pinpoint(<r>, parens: false, verb: none)
for the updated wording.`, that already supplies its own verb. The two
are independent: `parens: false` alone still says "modified on p. 3"
without the parentheses; `verb: none` alone keeps the parentheses
around a bare page number. Neither one alone fits every sentence shape
— that's why both exist rather than a single "compact" switch.

= excerpt: true — quoting the real text

Rather than a page number, the actual content of every passage carrying
the anchor — exactly as it reads in the manuscript right now, so it can
never go stale:

#m.snippet("/packages/palimpsest/docs/manual-snippets/pinpoint-excerpt.typ")

Manuscript:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-excerpt/manuscript-clean.png")

Response:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-excerpt/response-clean.png")

A passage declared with `summary:` ignores `excerpt` and always
renders "Removed: `‹summary›`" instead, as the second comment above
shows — there being no meaningful text left to quote in the clean
manuscript once the passage is fully removed.

= show-page: and quotes: — dropping the page, adding real quotation marks

#m.snippet("/packages/palimpsest/docs/manual-snippets/pinpoint-show-page-quotes.typ")

Manuscript:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-show-page-quotes/manuscript-clean.png")

Response:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-show-page-quotes/response-clean.png")

`show-page: false` drops the leading `*p. 1* —` — for a sentence that
already states where the excerpt comes from ("On page 1, `‹excerpt›`"),
or a caller who simply doesn't want it. `quotes: true` wraps the
excerpt in real, typeset quotation marks via Typst's native `quote()`.

`quotes: true` only ever *requests* quotation marks — a passage whose
content is a figure, a table, or a block equation never gets them,
regardless of this setting: forcing quotation marks onto a figure
produces two stray quote glyphs sitting alone above and below it, not
an improvement, so this is detected and declined automatically rather
than left for you to remember passage by passage.

= mode: — overriding style for one excerpt

An excerpt renders, by default, in whichever mode the *current* compile
is running under — clean text in `response.pdf`, struck-through/underlined
tracked style in `response-tracked.pdf` (both produced automatically
once `exchanges` is set, see
#link(calepin.url("/palimpsest/project/#the-letter-automatically-matched-to-the-manuscript-you-actually-send"))[The
letter, automatically] below). `mode:` overrides this for one call, in
either direction.

`mode: "tracked"`, called from a clean letter, shows the tracked style
even though `response.pdf` itself is otherwise all clean text:

#m.snippet("/packages/palimpsest/docs/manual-snippets/pinpoint-mode.typ")

Manuscript:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-mode/manuscript-clean.png")

Response:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-mode/response-clean.png")

Useful when the point being made is "we removed exactly what you
objected to," which a clean, final-text quote doesn't convey on its
own.

The reverse also works: `mode: "clean"`, called from a letter compiled
tracked (`--input variant=tracked`, `exchanges` set), shows the final
wording for one excerpt even though the rest of that same letter is
otherwise quoting tracked style:

#m.snippet("/packages/palimpsest/docs/manual-snippets/pinpoint-mode-clean-in-tracked-letter.typ")

Manuscript, tracked:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-mode-clean-in-tracked-letter/manuscript-tracked.png")

Response, tracked — the excerpt still reads as accepted, final text,
despite the compile being tracked:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-mode-clean-in-tracked-letter/response-tracked.png")

= on-empty: and format:

#m.snippet("/packages/palimpsest/docs/manual-snippets/pinpoint-on-empty-format.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/pinpoint-on-empty-format/result-clean.png")

`on-empty:` controls what happens when no passage anywhere carries the
given anchor — `auto` (the default) warns, `none` shows nothing,
anything else is shown as-is. `format:` replaces the default page-list
wording entirely, with a function `(pages-array, has-marks) -> content`
— `has-marks` is the same flag that drives the automatic
"modified"/"see" switch above, passed through so a fully custom format
can make that same distinction without querying the bundle again. For a
journal with its own citation convention.

#m.chapter-nav(
  prev: ("/palimpsest/exchanges/", "Writing the exchanges"),
  next: ("/palimpsest/xref/", "xref"),
)
