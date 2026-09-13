# typst-contexture-site

Source for the `contexture` ecosystem documentation site, published via
GitHub Pages at <https://eusebe.github.io/typst-contexture-site>.

Built with [Calepin](https://vincentarelbundock.github.io/calepin/), a
static-site generator that compiles Typst source directly to HTML.

## Structure

- `index.typ` — ecosystem overview.
- `contexture/`, `palimpsest/`, `equator/`, `colophon/` — one landing
  page per package.
- `combining/` — using more than one package in the same compile.
- `packages/*` — git submodules pointing at each package's own
  repository (for their PDFs, examples, and full manuals, linked from
  this site until their content is progressively migrated in).
- `calepin.toml` — site config: menus, sidebar, theme.

## Building locally

Requires Rust (`cargo install --locked --git
https://github.com/vincentarelbundock/calepin` — see the policy note
below) and a recent Typst.

```sh
git submodule update --init --recursive
calepin compile . _site
calepin serve _site
```

## Versioning policy

Calepin is under active development with no stability guarantees
between versions. Always reinstall/update Calepin
(`cargo install --locked --git https://github.com/vincentarelbundock/calepin`)
before making local changes, and let CI do the same on every deploy —
never pin or cache a specific Calepin version. See
`../contexture-ecosystem/ECOSYSTEM-WEBSITE-PLAN.md` for the full
rationale.

## Deployment

`.github/workflows/deploy.yml` rebuilds and publishes the site to
GitHub Pages on every push to `main`.
