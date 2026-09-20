#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Marking changes])
#metadata((title: "Marking changes", translation_key: "palimpsest-marking")) <website-metadata>

#title()

/ `passage(anchors, body)`: the citable unit — wraps `body` (plain text
  and/or `add`/`del`/`rep`/`suppress`) and attaches the anchor(s) a
  response letter will resolve back to this location. Called as
  `passage(body)`, with no anchors, for a typo fix with no comment to
  answer. `anchors` — `<r1-2>`, `<e1>`, a co-author id like `<bob-3>`,
  or an array of these — gets a full chapter of its own next
  (#link(calepin.url("/palimpsest/anchors/"))[Anchors]); every example below either
  omits it or uses it exactly as seen in the
  #link(calepin.url("/palimpsest/quickstart/"))[quickstart] above.
/ `add(body)`: marks `body` as newly added.
/ `del(body)`: marks `body` as removed.
/ `rep(old, new)`: a replacement in one call.

#m.snippet("/packages/palimpsest/docs/manual-snippets/passage-basics.typ")

Compiled once clean:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/passage-basics/result-clean.png")

Once more with `--input variant=tracked`:

#m.screenshot("/packages/palimpsest/docs/manual-snippets/passage-basics/result-tracked.png")

Two things to notice: `add` shows nothing extra in clean mode — `body`
is just there, as if it had always been. `del` shows *nothing at all*
in clean mode — no `hide()`, no reserved space; a deletion that
survives into the clean version isn't a deletion.

= suppress

/ `suppress(note)`: like `del`, but never shows the real content, in
  *either* mode — only `note`, centered and italic, and only in tracked
  mode.

#m.snippet("/packages/palimpsest/docs/manual-snippets/marks-suppress.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/marks-suppress/result-tracked.png")

The obvious question is why this exists next to `del`, which already
hides its content in clean mode. The difference shows up specifically
in the *tracked* manuscript: `del` still renders the real removed
content there — struck through, as the previous section demonstrated.
Sometimes that's not what you want: a long passage struck through end
to end reads worse than a short note saying what used to be there, or
the removed content simply isn't worth showing again once it's gone.
`suppress` replaces it with `note` instead — centered, italic, shown
only in tracked mode — rather than the real thing, struck.

`suppress` takes no content to hide, only `note` — there's no
parameter for the real content at all, not even an unused one. Since
that content is never rendered by this function, in any mode, keeping
it as an argument would only be a place for some future edit to start
rendering it by accident, undoing the whole point.

If you want the removed material kept at hand in the source to
reconsider later, comment it out beside the call rather than deleting
it outright — a `//` line is never evaluated by Typst, so there's no
risk of it resurfacing on its own:

```typ
// #figure(table(...), caption: [The old table.])
#passage(<r2-1>)[#suppress[Table removed: see response.]]
```

The look of every mark above — color, underline vs. box, whether a
small anchor tag shows at the end — is controlled by two things,
covered in the next two chapters: the anchor itself (whose shape
decides the automatic per-reviewer/per-author color) and
`set-revisions` (any visual knob, changed anywhere in the document).
Anchors come first, since a couple of `set-revisions`'s own examples
already need one.

#m.chapter-nav(
  prev: ("/palimpsest/quickstart/", "Your first revision round"),
  next: ("/palimpsest/anchors/", "Anchors"),
)
