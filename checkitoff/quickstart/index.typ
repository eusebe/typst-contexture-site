#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Your first checklist])
#metadata((title: "Your first checklist", translation_key: "checkitoff-quickstart")) <website-metadata>

#title()

= Installing and compiling

```typ
#import "@preview/checkitoff:0.1.0": *
#import "@preview/contexture:0.1.0": bundle
```

A manuscript plus its completed checklist compiles with one command:

```sh
typst compile --features bundle --format bundle main.typ
```

This produces `manuscript.pdf` and `checklist.pdf` from the same compile.
A second, optional compile is useful while drafting:

```sh
typst compile --features bundle --format bundle --input preview=true main.typ
```

This produces `manuscript-preview.pdf` only — no `checklist.pdf` in this
compile, and #link(calepin.url("/checkitoff/project/"))[Wiring a real project] explains
why — with every `check()`'d span lightly highlighted and tagged with
its item id, so you can see at a glance what's covered so far and
where. Nothing about it ever reaches the real submission.

#m.note(title: "About the examples in this manual")[
  Every example here is a single, self-contained file, compiled
  directly — the simplest way to show what each function does on its
  own. `check()` and `na()` even work in a plain `typst compile`, with
  no bundle at all: that's the form used for the very next example. A
  real, multi-file project instead wires its manuscript and its
  checklist together explicitly — that pattern is covered once you've
  seen the pieces it's built from, in
  #link(calepin.url("/checkitoff/project/"))[Wiring a real project].
]

= A first, complete example

The smallest complete example: a four-item made-up checklist — a real
project would pass `checklists.consort` or another built-in grid
instead (see #link(calepin.url("/checkitoff/checklists/"))[Built-in checklists]), but a
tiny one keeps the whole grid on one page here — a short manuscript,
and two `check()` calls plus one `na()`.

#m.snippet("/packages/checkitoff/docs/manual-snippets/bundle-basics.typ")

A few things to notice in that file, top to bottom:

+ `tiny` is nothing but a dictionary: a `name`, a `full-name`, and a
  list of `items`, each with a `section`, an optional `topic`/`group`,
  an `id`, and a `description`. Nothing here is specific to checkitoff's
  internals — it's the same shape every built-in checklist uses, and
  the same shape a house checklist of your own would use.
+ `#show: contexture.bundle.with(...)` is the one line of setup a real
  project needs: it tells Typst which checklist is active
  (`checklist(checklist: tiny)`) and applies a page template to the
  manuscript. Everything after it is your manuscript, written exactly
  as you'd write it without checkitoff at all.
+ `#check("1a")[...]` wraps a passage of the manuscript and records
  "this is where item 1a is answered." `#na("14", reason: [...])`
  instead declares, in one line, that item 14 doesn't apply here — with
  a justification, not a silent omission.

Compiled plain, `manuscript.pdf` shows nothing but ordinary prose — no
box, no id, no visible trace of `check()` at all:

#m.screenshot("/packages/checkitoff/docs/manual-snippets/bundle-basics/manuscript-plain.png")

Compiled again with `--input preview=true` — a drafting view only,
never part of the real submission — each checked span is lightly
highlighted with its item id superscripted, so you can see coverage at
a glance while writing (`checklist.pdf` isn't produced in this compile
at all):

#m.screenshot("/packages/checkitoff/docs/manual-snippets/bundle-basics/manuscript-preview.png")

And here is `checklist.pdf`, from the first, plain compile — the actual
deliverable:

#m.screenshot("/packages/checkitoff/docs/manual-snippets/bundle-basics/checklist-plain.png")

Worth noticing in that grid: "Randomisation" (item 10/11's shared
`group`) renders as its own band nested inside the "Methods" section
band — an item's `group`, when it has one, always gets this treatment.
Item 14 shows `N/A` in the Page column, with its justification printed
verbatim underneath, in the "Not applicable" block — both come
directly from the single `na("14", reason: [...])` call above, with no
`check()` anywhere for that id. If an item had been left neither
`check()`'d nor `na()`'d, its Page cell would instead show a small
warning marker — covered in full in
#link(calepin.url("/checkitoff/diagnostics/"))[Reading the grid], once the individual
marking functions have been introduced properly.

= Recommended workflow

The example above is the whole mechanism; a real manuscript just
repeats the same two calls, `check()` and `na()`, at every relevant
spot. In practice:

+ Pick a checklist — one of the built-in ones
  (#link(calepin.url("/checkitoff/checklists/"))[Built-in checklists]), or your own
  dictionary of the same shape.
+ Write the manuscript as usual, wrapping each passage that answers an
  item in `check(id)[...]`, and grouping every genuinely inapplicable
  item under `na(id, reason: [...])`.
+ While drafting, compile with `--input preview=true` from time to
  time — a quick visual check of what's covered and what isn't yet,
  with no effect on the real manuscript.
+ Once the draft feels complete, compile normally and read
  `checklist.pdf`. Its Diagnostics block
  (#link(calepin.url("/checkitoff/diagnostics/"))[below]) lists anything unresolved: an
  item never covered, a `check()` with nothing in it, an id that
  doesn't match any item, or a genuine contradiction.
+ Fix each one — add the missing `check()`, or an `na()` with a real
  reason — and recompile.
+ Before submission, compile once with `strict: true`
  (#link(calepin.url("/checkitoff/diagnostics/#strict-mode"))[below]): every remaining
  diagnostic becomes a hard compile error instead of a soft marker, a
  clean pass-fail gate.
+ Submit `manuscript.pdf` and `checklist.pdf` together — they came from
  the same compile, so the page numbers in one are guaranteed to match
  the other.

#m.chapter-nav(
  prev: ("/checkitoff/", "checkitoff overview"),
  next: ("/checkitoff/marking/", "Marking items: check and na"),
)
