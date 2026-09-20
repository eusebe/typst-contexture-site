#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [contexture])
#metadata((title: "Overview", translation_key: "home")) <website-metadata>

#title[#box(m.inline-logo("contexture", css-height: "1em", pdf-height: 22pt)) contexture]

*contexture* is a small Typst engine for producing several
cross-referencing documents from one compile — a manuscript plus
companions that can cite its _real_, final page numbers, because
they're composed together in the same pass, not two unrelated files
that happen to sit next to each other.

Three packages are built on it today, each solving one distinct,
self-contained problem:

- #link(calepin.url("/palimpsest/"))[*palimpsest*] — manuscript revisions and a reviewer response letter that cites the real pages.
- #link(calepin.url("/checkitoff/"))[*checkitoff*] — reporting-guideline checklists (CONSORT, PRISMA, SPIRIT, STARD, STROBE) filled in automatically, with the real pages.
- #link(calepin.url("/colophon/"))[*colophon*] — a companion audit of the composed manuscript: word counts, reading time, a figure/table inventory — no per-passage markup required.

= Which one do I need?

- *Responding to peer review, and want the letter to cite real pages?*
  Start with #link(calepin.url("/palimpsest/"))[palimpsest].
- *Filling in a CONSORT/PRISMA/SPIRIT/STARD/STROBE grid?* Start with
  #link(calepin.url("/checkitoff/"))[checkitoff].
- *Want a word count, reading time, or figure/table inventory of the
  manuscript as actually laid out?* Start with
  #link(calepin.url("/colophon/"))[colophon].
- *Need two or more of the above on the same manuscript?* Each page
  above is self-contained on its own — once you've got one working, see
  #link(calepin.url("/combining/"))[Combining packages] for how to add
  another, and the two rules that matter if they might touch the same
  span of text.

Whichever you pick, that page is the whole story: quickstart, the full
feature set, and installation, with no detour through the others or
through `contexture` itself required first.

= Why several packages, not one

Each package above solves one distinct problem (tracking revisions,
filling in a checklist, auditing word counts) with its own vocabulary
and its own author-facing functions. What they share isn't a feature —
it's a mechanism: the ability to look up something recorded in one
document from another, by its real, final position. `contexture`
factors _only_ that mechanism out, once, so:

- a manuscript can be revised (`palimpsest`), checked against CONSORT (`checkitoff`), and audited (`colophon`) — all three, in one compile, none of them aware of the other two's existence.
- a future fourth package gets the same primitive for free, without any of the first three having to change.

You'll rarely reach for `contexture` on its own — it's the shared
foundation the three packages above are built on, not a tool you use
directly. Curious what's underneath, or building a new package on the
same mechanism? #link(calepin.url("/contexture/"))[contexture]'s own
manual, last on this site on purpose, covers it — with the same
worked examples, from the other side.
