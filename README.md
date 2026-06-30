# PaBST (and BaM!) website

A [Quarto](https://quarto.org) website for the annual *Philosophy and Biology
Shop Talks* (and *Biology and Models* Camp). Live at
<https://brettc.github.io/pabst-website/>.

## Setup

- **Quarto** — install from <https://quarto.org/docs/get-started/> (`brew install quarto`)
- **just** (optional task runner) — `brew install just`

## Working on the site

```sh
just preview   # live-reloading local server (quarto preview)
just render    # build into _site/
just check     # verify the Quarto install
```

No `just`? Use `quarto preview` / `quarto render` directly.

- Content lives in `.qmd` files: `index.qmd`, `about.qmd`, and one folder per year
  (`2026/` etc.) with `talks.qmd`, `people.qmd`, `photos.qmd`. Photos go in
  `<year>/photos/`. See the Quarto [authoring](https://quarto.org/docs/authoring/markdown-basics.html)
  and [websites](https://quarto.org/docs/websites/) docs.
- The homepage lists years automatically via a [listing](https://quarto.org/docs/websites/website-listings.html).
- Add a new year: `just new-year 2027`, then add its navbar dropdown in `_quarto.yml`.

## Deploying

Push to `main` — that's it. A [GitHub Action](https://quarto.org/docs/publishing/github-pages.html#github-action)
(`.github/workflows/publish.yml`) renders the site and publishes it to the
`gh-pages` branch, which GitHub Pages serves. No need to commit `_site/`.
