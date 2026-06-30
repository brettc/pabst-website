# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A [Quarto](https://quarto.org) static website for **PABST (and BAM!)**, an annual
conference. The site has an overview homepage plus one folder per conference year,
each following an identical Talks / People / Photos pattern.

## Commands

Recipes are in the `justfile` (run `just` / `just help` to list):

- `just preview` — live-reloading dev server (`quarto preview`)
- `just render` — build the static site into `_site/`
- `just check` — verify the Quarto install
- `just clean` — remove `_site/` and `.quarto/`
- `just new-year 2027 [2026]` — scaffold a new year by cloning an existing one

Plain Quarto also works: `quarto render`, `quarto preview`, `quarto render index.qmd`.
Requires Quarto (developed against 1.9.x). There is no Node/npm toolchain.

## Structure

- `_quarto.yml` — site config: navbar (one dropdown per year), HTML format, theme.
- `index.qmd` — overview prose + a Quarto **listing** (`contents: "*/index.qmd"`)
  that auto-generates a card per year from each year's front-matter `title` and
  `description`. New years appear automatically; no edit needed here.
- `about.qmd` — about page.
- `<year>/` (e.g. `2025/`, `2026/`) — one folder per conference year, each with:
  - `index.qmd` — year landing page. Its `title` and `description` front matter
    feed the homepage card, so always set both.
  - `talks.qmd` — programme: a `## heading` per talk with speaker + abstract.
  - `people.qmd` — speakers and organisers (definition-list `Name : bio` entries).
  - `photos.qmd` — gallery via `::: {layout-ncol=3}` of images; `group=` enables
    the lightbox. Image files live in `<year>/photos/`.
- `assets/photos/placeholder.svg` — stand-in image (copied into each `<year>/photos/`).
- `styles.css` — site-wide CSS overrides (currently empty).
- `_site/` and `.quarto/` are build artifacts (gitignored); never edit by hand.

## Publishing

`.github/workflows/publish.yml` renders the site and pushes it to the `gh-pages`
branch on every push to `main` (and via manual `workflow_dispatch`). It uses
`quarto-dev/quarto-actions/setup@v2` + `publish@v2`; the site has no executed code,
so there is no `_freeze` to commit. `_site/` is gitignored — CI rebuilds it.

One-time setup on the GitHub repo:

1. Settings → Actions → General → Workflow permissions → **Read and write permissions**.
2. Settings → Pages → Source → **Deploy from a branch**, branch `gh-pages` / root
   (the first workflow run creates the `gh-pages` branch automatically).

## Conventions

- Filler text uses the Quarto `{{< lipsum N >}}` shortcode, not pasted lorem text.
- Adding a year: `just new-year <YEAR>`, then edit `<YEAR>/*.qmd` and add a navbar
  dropdown for it in `_quarto.yml` (the homepage listing picks it up on its own).
- Theme is plain `cosmo` (kept basic for now); no `_brand.yml`/SCSS layer.
