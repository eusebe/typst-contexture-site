#import "/.calepin/calepin.typ" as calepin

#set document(title: [contexture])
#metadata((title: "Overview", translation_key: "home")) <website-metadata>

#title()

*contexture* is a small Typst engine for producing several
cross-referencing documents from one compile — a manuscript plus
companions that can cite its _real_, final page numbers, because
they're composed together in the same pass, not two unrelated files
that happen to sit next to each other.

Three packages are built on it today:

- #link("/palimpsest/")[*palimpsest*] — manuscript revisions and a reviewer response letter that cites the real pages.
- #link("/equator/")[*equator*] — reporting-guideline checklists (CONSORT, PRISMA, SPIRIT, STARD, STROBE) filled in automatically, with the real pages.
- #link("/colophon/")[*colophon*] — a companion audit of the composed manuscript: word counts, reading time, a figure/table inventory — no per-passage markup required.

You'll rarely reach for `contexture` on its own — see its own page for
what it actually provides, and #link("/combining/")[Combining packages]
for what happens when two of the above end up touching the same
manuscript.

= Why several packages, not one

Each package above solves one distinct problem (tracking revisions,
filling in a checklist, auditing word counts) with its own vocabulary
and its own author-facing functions. What they share isn't a feature —
it's a mechanism: the ability to look up something recorded in one
document from another, by its real, final position. `contexture`
factors _only_ that mechanism out, once, so:

- a manuscript can be revised (`palimpsest`), checked against CONSORT (`equator`), and audited (`colophon`) — all three, in one compile, none of them aware of the other two's existence.
- a future fourth package gets the same primitive for free, without any of the first three having to change.

= Where to go next

- New to the ecosystem? Start with whichever package solves the problem you actually have — #link("/palimpsest/")[palimpsest], #link("/equator/")[equator], or #link("/colophon/")[colophon] — each page is self-contained.
- Combining two or more in the same compile? #link("/combining/")[Combining packages] covers the two rules that matter once they might touch the same span of text.
- Curious what's underneath, or building a new package on the same mechanism? #link("/contexture/")[contexture] itself.
