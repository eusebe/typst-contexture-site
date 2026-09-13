#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Writing the exchanges: reviewer, editor, exchange])
#metadata((title: "Writing the exchanges: reviewer, editor, exchange", translation_key: "palimpsest-exchanges")) <website-metadata>

#title()

/ `reviewer(n, body)`: groups a reviewer's comments under a heading
  colored by their number.
/ `editor(body)`: same, for the editor's own comments.
/ `exchange(anchor, comment, response)`: renders the quoted comment
  (in italics) and the response, with a header generated from the
  anchor.

#m.snippet("/packages/palimpsest/docs/manual-snippets/exchanges-reviewer-editor.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/exchanges-reviewer-editor/result-tracked.png")

`exchange` checks, unconditionally, that its anchor matches a passage
somewhere — an orphan comment answering nothing is always worth
flagging, so this check has no `require-exchange`-style opt-out.

= Co-authors: author, note

/ `author(id, body)`: groups one co-author's own notes under a heading,
  colored and named the same way an anchor like `<bob-3>` already
  would be.
/ `note(anchor, text)`: a single block — no comment to quote, just the
  author's own explanation. `exchange(anchor, text)`, with two
  arguments instead of three, renders identically.

#m.snippet("/packages/palimpsest/docs/manual-snippets/exchanges-author.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/exchanges-author/result-tracked.png")

= xcomment

/ `xcomment(anchor)`: a clickable cross-reference to another exchange,
  plus its page — "as already answered in comment R1-2."

#m.snippet("/packages/palimpsest/docs/manual-snippets/exchanges-xcomment.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/exchanges-xcomment/result-tracked.png")

= Header wording: comment-word, change-word, term:

The noun in a header — "comment" for reviewer/editor, "change" for a
co-author — is `set-revisions(comment-word:, change-word:)`, global
from that point on, or `term:` on one `exchange`/`note` call for just
that occurrence:

#m.snippet("/packages/palimpsest/docs/manual-snippets/exchanges-words.typ")

#m.screenshot("/packages/palimpsest/docs/manual-snippets/exchanges-words/result-tracked.png")

`xcomment` echoes whichever word the exchange it points to actually
used — reading it back from that exchange's own data rather than
recomputing it, so `#xcomment(<bob-2>)`'s explicit `term: "aside"`
stays "aside" no matter where it's cited from. An *unoverridden* word,
though, is resolved at the position where it's *read*, not where it was
written: `<r1-1>`'s own exchange, near the top, renders "comment" — the
default, in effect at that point — but `#xcomment(<r1-1>)` at the very
bottom, after the global override, reads back "remark" for that same
exchange. A global change to `comment-word`/`change-word` partway
through a file affects every unoverridden reference read afterward,
regardless of which word was showing where that exchange itself was
originally written.

#m.chapter-nav(
  prev: ("/palimpsest/shortcuts/", "Shortcuts"),
  next: ("/palimpsest/pinpoint/", "pinpoint: the manuscript/letter link"),
)
