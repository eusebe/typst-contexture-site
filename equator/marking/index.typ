#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Marking items: check and na])
#metadata((title: "Marking items: check and na", translation_key: "equator-marking")) <website-metadata>

#title()

/ `check(id, body)`: anchors `body` to item `id` of whichever checklist
  is active for this compile, and renders `body` exactly as written.
  Zero visual footprint in the plain compile — safe inside any
  journal template's flow. Under `--input preview=true`, `body` gets a
  light highlight with the item id superscripted, purely as a drafting
  aid.
/ `na(id, reason: none)`: declares item `id` not applicable to this
  manuscript, with an optional justification. Renders nothing at the
  call site — it's typically grouped in one dedicated block rather than
  scattered through the text, as in the previous chapter's example.

A minimal, standalone example — no bundle involved, just `check()` in a
plain file:

#m.snippet("/packages/equator/docs/manual-snippets/marks-check-basics.typ")

Compiled once, plain:

#m.screenshot("/packages/equator/docs/manual-snippets/marks-check-basics/result-plain.png")

Once more with `--input preview=true`:

#m.screenshot("/packages/equator/docs/manual-snippets/marks-check-basics/result-preview.png")

`check()` doesn't need to know which checklist is active, or even that
one exists — it just anchors `body` under `id`; whether that id means
anything is only decided later, when the grid is built. That's why this
file compiles and renders correctly entirely on its own, with no
`#show: bundle.with(...)` anywhere. It's also why an id that turns out
not to match any item is a diagnostic caught later, in the grid, rather
than an error here.

An item can legitimately be checked more than once — a method described
once and its rationale discussed elsewhere, say — in which case the
grid lists every page it was found on. The one deliberate exception is
a single passage that straddles a page break: see
#link("/equator/page-breaks/")[The page-break idiom] for the recommended
way to get a correct, two-page citation for that case specifically.

`na()` is the explicit counterpart to `check()`: some items genuinely
don't apply to a given manuscript (a trial with no serious adverse
events has nothing to say for a "Harms" item, for instance). Declaring
it, with a reason, turns "item never mentioned" from an oversight worth
flagging into a documented, deliberate choice.

= The point-marker form: check(id) alone

`check(id, body)` renders `body` — and that's the right call almost
every time, since most items simply live at their own spot in the
manuscript. Occasionally, though, the passage an item covers is already
being rendered by something else — most commonly another package's own
marking call, when what a reviewer asked you to change happens to *be*
your answer to a checklist item. Calling `check(id, body)` there too
would print the same text a second time, since it always renders `body`
itself.

For exactly that case, `check(id)` — one argument, no body — only ever
registers the item's location; it never renders anything, ever. `body`
must already be displayed by something else.

#m.snippet("/packages/equator/docs/manual-snippets/marks-check-point-marker.typ")

Compiled once, plain — the sentence appears exactly once, exactly as
written:

#m.screenshot("/packages/equator/docs/manual-snippets/marks-check-point-marker/manuscript-plain.png")

Once more with `--input preview=true` — a small superscripted id, but
no highlight box: there's no body here to wrap one around, but the id
is still shown as a drafting aid:

#m.screenshot("/packages/equator/docs/manual-snippets/marks-check-point-marker/manuscript-preview.png")

The item still resolves correctly in `checklist.pdf`, exactly as if it
had been written `check(id, body)`. The only function that notices the
difference is `excerpt-of`
(#link("/equator/excerpts/")[Quoting the real wording]): with no body to
quote, an occurrence marked this way simply contributes no excerpt,
which is the honest answer, not an error. The "blank content" diagnostic
never fires on it either — a missing body here is the deliberate shape
of this form, not the mistake it would be for `check(id)[]`.

#m.note[
  The most common reason to reach for this form — combining equator
  with a package that already renders the text, such as
  `@preview/palimpsest`'s tracked-changes marks — is covered in full in
  the closing chapter, #link("/equator/ecosystem/")[Equator in the
  contexture ecosystem].
]

#m.chapter-nav(
  prev: ("/equator/quickstart/", "Your first checklist"),
  next: ("/equator/diagnostics/", "Reading the grid"),
)
