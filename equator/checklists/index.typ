#import "/.calepin/calepin.typ" as calepin
#import "/_shared/manual.typ" as m

#set document(title: [Built-in checklists])
#metadata((title: "Built-in checklists", translation_key: "equator-checklists")) <website-metadata>

#title()

#table(
  columns: (auto, auto, auto, 1fr),
  align: (left, left, center, left),
  stroke: 0.5pt + luma(180),
  table.header[*`checklists.` key*][*Guideline*][*Items*][*Notes*],
  [`consort`], [CONSORT 2025 (randomised trials)], [42], [Landscape A4; one mid-level group, "Randomisation" (17a–21d).],
  [`prisma`], [PRISMA 2020 (systematic reviews)], [42], [Landscape US Letter; no mid-level groups.],
  [`spirit`], [SPIRIT 2025 (trial protocols)], [53], [Landscape US Letter.],
  [`stard`], [STARD 2015 (diagnostic accuracy studies)], [34], [Portrait A4.],
  [`strobe.cohort`], [STROBE (cohort studies)], [22], [Portrait A4.],
  [`strobe.case_control`], [STROBE (case-control studies)], [22], [Portrait A4.],
  [`strobe.cross_sectional`], [STROBE (cross-sectional studies)], [22], [Portrait A4.],
)

Every entry is transcribed from its official source document, including
its citation and license notice — reproduced verbatim in the "citation"
block at the bottom of `checklist.pdf` — and its real column widths and
section colors, read directly from the source file rather than guessed.
`strobe` is itself a dictionary of the three study-design variants above
rather than one single checklist: there is no fourth, "combined"
variant, since that source bundles all three designs' wording into a
single item per row, which doesn't fit the one-description-per-id shape
every other checklist here uses.

A checklist is plain data, as #link("/equator/quickstart/")[the
quickstart] already showed — nothing about `check()`, `na()`,
`render-checklist`, or the `checklist(...)` satellite is specific to
CONSORT or to any built-in grid above. A project with its own house
checklist, or an emerging reporting guideline not built in yet, simply
passes its own dictionary of the same shape in `checklist:` instead.

#m.chapter-nav(
  prev: ("/equator/project/", "Wiring a real project"),
  next: ("/equator/ecosystem/", "Equator in the contexture ecosystem"),
)
