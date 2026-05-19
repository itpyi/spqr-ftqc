# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Typst-based book on Fault-Tolerant Quantum Computation (S.P.Q.R. — Stochastically Perturbed Quantum Registers), built with Shiroa for static site generation and auto-deployed to GitHub Pages at `http://itpyi.site/spqr-ftqc/`.

## Build & Development

```bash
# Install shiroa CLI (if not already installed)
cargo install --git https://github.com/Myriad-Dreamin/shiroa.git --tag v0.3.0 --locked shiroa

# Build the book
shiroa build

# Local dev with auto-reload (preferred)
./watch-and-serve.sh

# Serve without auto-reload
shiroa serve

# Test a single Typst file
typst compile <file>.typ
```

## Version Lock

- **Shiroa CLI**: v0.3.0 (installed via cargo from git tag)
- **Shiroa Library**: `@preview/shiroa:0.2.0` (imported in `book.typ` and `templates/page.typ`)
- These versions must stay in sync. Do not change either without testing thoroughly.

## Architecture

### Book structure (Shiroa/Typst)

The book is defined by `book.typ`, which:
- Imports `@preview/shiroa:0.2.0:*` and uses `#show: book` to activate Shiroa's book template
- `#book-meta(…)` defines the title and chapter hierarchy via a `summary` block
- `#chapter("file.typ")[Title]` registers a top-level chapter; nesting is done with indented lists using `- #chapter(…)`
- `#prefix-chapter("file.typ")[Title]` is an older alternative for chapters without nesting
- Re-exports the page template as `#let book-page = project` from `templates/page.typ`

Each content file (e.g., `introduction.typ`) imports the page template and shows it:
```typst
#import "/book.typ": book-page
#show: book-page.with(title: "Chapter Title")
```

### Templates (`templates/`)

- **`page.typ`** — Main page template (`project` function). Controls fonts, sizes, heading styles, code block rendering (via zebraw), math equation display, and theme-aware coloring. Imports from `@preview/shiroa:0.2.0` for target detection (web vs PDF) and from `@preview/zebraw:0.4.5` for syntax highlighting.
- **`theme-style.toml`** — Color theme definitions (light, rust, coal, navy, ayu). Each theme specifies `color-scheme`, `main-color`, `dash-color` (accent), and `code-theme` (syntax highlighting `.tmTheme` file).
- **`ebook.typ`** — PDF/ebook output template, separate from the web build path.
- **`tokyo-night.tmTheme`** — Syntax highlighting theme for dark color schemes.

### CI/CD (`.github/workflows/deploy.yml`)

- Triggers on push to `main` and manual dispatch
- Installs Rust toolchain, caches cargo, installs Shiroa v0.3.0, builds with `shiroa build --path-to-root /spqr-ftqc/`
- The `--path-to-root /spqr-ftqc/` flag is **critical** — it sets the base path for GitHub Pages (repo name). Removing it breaks CSS/asset loading on the live site.
- Deploys `dist/` to GitHub Pages

## Key Constraints

- **Never commit `dist/`** — it's gitignored and CI builds it
- **`--path-to-root /spqr-ftqc/`** must be preserved in CI build commands for correct GitHub Pages paths
- **Version coupling**: Shiroa CLI and library versions must remain compatible (currently CLI v0.3.0 ↔ library v0.2.0)
- **`shiroa serve` does not watch files** — always use `./watch-and-serve.sh` for live reload during development
