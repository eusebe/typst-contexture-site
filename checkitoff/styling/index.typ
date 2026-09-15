#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Styling the grid])
#metadata((title: "Styling the grid", translation_key: "checkitoff-styling")) <website-metadata>

#title()

Every visual knob the grid and `check()`'s preview highlighting use
goes through one shared mechanism, resolved in three layers, each
overriding only what the previous layer left unset:

+ checkitoff's own package default — generic and checklist-agnostic
  (portrait A4, no color, "use whatever the ambient template already
  set");
+ the active checklist's own `style:` field, if it has one — CONSORT's
  real landscape A4 layout and column widths, taken from its official
  source document, is exactly this layer;
+ whatever you explicitly ask for via `set-style(...)`.

`set-style(...)` takes every knob as a keyword, `auto` by default
("don't touch this one"); repeated calls merge rather than reset:

```typ
#set-style(
  preview-color: auto,        // check()'s preview-mode highlight color
  show-id: auto,               // superscript the id in preview mode?
  paper: auto,                 // grid page size, e.g. "a4", "us-letter"
  landscape: auto,             // grid page orientation
  columns: auto,                // 4 column widths, e.g. (18%, 7%, 1fr, 10%)
  font: auto,                  // grid text font
  text-size: auto,             // grid text size
  header-fill: auto,           // header row background
  header-text-color: auto,
  section-fill: auto,          // section band background
  section-text-color: auto,
  group-fill: auto,            // mid-level group band background
  group-text-color: auto,
)
```

An override on a checklist with no `style:` of its own:

#m.snippet("/packages/checkitoff/docs/manual-snippets/style-checklist-override.typ")

#m.screenshot("/packages/checkitoff/docs/manual-snippets/style-checklist-override/checklist-plain.png")

`preview-color`/`show-id` also apply to `check()`'s own preview-mode
highlight, independently of any checklist — `check()` doesn't know
which checklist is active, by design:

#m.snippet("/packages/checkitoff/docs/manual-snippets/style-preview.typ")

#m.screenshot("/packages/checkitoff/docs/manual-snippets/style-preview/result-preview.png")

These values always win, over both checkitoff's package default and the
active checklist's own `style:` — your explicit ask, for the manuscript
you're compiling right now, is the most specific signal available. A
checklist that ships its own faithful `style:` (CONSORT, PRISMA, ...)
keeps looking like its real source document by default; `set-style(...)`
is for the cases where that's not what you want — matching a specific
journal's house style, or simply personal preference.

#m.chapter-nav(
  prev: ("/checkitoff/page-breaks/", "The page-break idiom"),
  next: ("/checkitoff/project/", "Wiring a real project"),
)
