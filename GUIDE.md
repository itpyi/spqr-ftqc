# FTQC Book Guide - Building and Customization

This guide covers how to build, customize, and manage your Fault-Tolerant Quantum Computing (FTQC) notes book using Shiroa and Typst.

## Table of Contents
- [Building the Book](#building-the-book)
- [Live Preview with Auto-Reload](#live-preview-with-auto-reload)
- [Adding Chapters](#adding-chapters)
- [Customizing Styles](#customizing-styles)
- [Changing Fonts](#changing-fonts)
- [Customizing Colors and Themes](#customizing-colors-and-themes)
- [Advanced Configuration](#advanced-configuration)
- [Troubleshooting](#troubleshooting)

---

## Building the Book

### Basic Build
Build the book to generate HTML output:
```bash
shiroa build
```

This will:
- Compile all `.typ` files referenced in `book.typ`
- Generate HTML files in the `dist/` directory
- Create multiple theme variants (light, dark, etc.)
- Build search index

### View the Output
Open the generated book in your browser:
```bash
open dist/index.html
```

---

## Live Preview with Auto-Reload

### Important Note About File Watching
**Shiroa does not include built-in file watching.** The `shiroa serve` command only serves the pre-built files from the `dist/` directory. It will not automatically detect changes or rebuild your book.

### Option 1: Use the Watch Script (Recommended)
We provide a `watch-and-serve.sh` script that monitors your `.typ` files and automatically rebuilds when changes are detected:

```bash
./watch-and-serve.sh
```

This script will:
- Build your book initially
- Start the shiroa server at `http://127.0.0.1:25520`
- Watch for changes to `.typ` and `.toml` files
- Automatically rebuild when files change

To use a custom port:
```bash
./watch-and-serve.sh 8080
```

**For better performance, install fswatch:**
```bash
brew install fswatch
```

### Option 2: Manual Serve (No Auto-Reload)
If you prefer to manually rebuild, you can run the serve command:
```bash
shiroa serve
```

Then rebuild manually in another terminal whenever you make changes:
```bash
shiroa build
```

### Option 3: Use Editor Preview
For live preview while editing, use one of these editor-based approaches:
- [Tinymist VSCode Extension](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist)
- [Typst Preview VSCode Extension](https://marketplace.visualstudio.com/items?itemName=mgt19937.typst-preview)
- [typst.vim](https://github.com/kaarmu/typst.vim) for Neovim

### Custom Port
```bash
shiroa serve --addr 127.0.0.1:8080
```

---

## Adding Chapters

### Step 1: Create a New Typst File
Create a new `.typ` file in your project directory:

```bash
# Example: Create a new chapter on error correction
touch error-correction.typ
```

### Step 2: Add Content to Your Chapter
Edit `error-correction.typ`:

```typst
#import "/book.typ": book-page

#show: book-page.with(title: "Quantum Error Correction")

= Quantum Error Correction

== Introduction
Error correction is fundamental to FTQC...

== The Three-Qubit Code
The simplest quantum error correcting code...

== Stabilizer Codes
Stabilizer formalism provides...
```

### Step 3: Register in book.typ
Edit `book.typ` to add your chapter to the summary:

```typst
#book-meta(
  title: "Fault-Tolerant Quantum Computing (FTQC) Notes",
  summary: [
    #prefix-chapter("sample-page.typ")[Introduction]
    #prefix-chapter("error-correction.typ")[Quantum Error Correction]
    // Add more chapters here
  ]
)
```

### Chapter Hierarchy
You can create nested chapters:

```typst
summary: [
  #prefix-chapter("intro.typ")[Introduction]
  
  = Part I: Foundations
  #prefix-chapter("qec-basics.typ")[QEC Basics]
  #prefix-chapter("stabilizers.typ")[Stabilizer Codes]
  
  = Part II: Surface Codes
  #prefix-chapter("surface-codes.typ")[Surface Codes]
  #prefix-chapter("lattice-surgery.typ")[Lattice Surgery]
]
```

---

## Customizing Styles

All styling is controlled in `templates/page.typ`.

### Page Layout

Edit `templates/page.typ` to adjust page dimensions:

```typst
// Line ~50-60: Sizes
#let main-size = if is-pdf-target {
  11pt  // PDF text size
} else {
  16px  // Web text size
}

#let h1-size = main-size * 2.0
#let h2-size = main-size * 1.6
#let h3-size = main-size * 1.3
```

### Heading Styles

Find and modify heading configurations (around line 100+):

```typst
#show heading.where(level: 1): it => {
  set text(size: h1-size, weight: "bold", fill: main-color)
  it
}

#show heading.where(level: 2): it => {
  set text(size: h2-size, weight: "semibold", fill: dash-color)
  it
}
```

---

## Changing Fonts

Fonts are defined in `templates/page.typ` (around line 36-48).

### Main Text Font

```typst
#let main-font = (
  "Charter",              // Primary font (if installed)
  "Source Han Serif SC",  // Fallback for CJK
  "Libertinus Serif",     // Shiroa's embedded font (always available)
)
```

### Code Font

```typst
#let code-font = (
  "BlexMono Nerd Font Mono",  // Primary (if installed)
  "Fira Code",                 // Alternative monospace
  "DejaVu Sans Mono",          // Shiroa's embedded font
)
```

### Custom Font Examples

**For a modern sans-serif look:**
```typst
#let main-font = (
  "Inter",
  "Helvetica Neue", 
  "Arial",
  "Libertinus Serif",  // Keep as fallback
)
```

**For academic/traditional style:**
```typst
#let main-font = (
  "TeX Gyre Termes",    // Times New Roman alternative
  "Palatino",
  "Georgia",
  "Libertinus Serif",
)
```

**For programming/technical:**
```typst
#let code-font = (
  "JetBrains Mono",
  "Source Code Pro",
  "Cascadia Code",
  "DejaVu Sans Mono",   // Keep as fallback
)
```

### Installing Custom Fonts

**macOS:**
- Double-click `.ttf`/`.otf` files to install
- Or copy to `~/Library/Fonts/`

**Linux:**
- Copy fonts to `~/.local/share/fonts/`
- Run `fc-cache -fv`

**Tell Shiroa about custom font directories:**
```bash
shiroa build --font-path ~/my-custom-fonts/
```

Or set environment variable:
```bash
export TYPST_FONT_PATHS=~/my-custom-fonts/
shiroa build
```

---

## Customizing Colors and Themes

Themes are defined in `templates/theme-style.toml`.

### Available Themes
- `light` - Light background, dark text
- `rust` - Rust-inspired light theme
- `coal` - Dark theme with blue accents
- `navy` - Dark navy theme
- `ayu` - Dark theme with cyan accents

### Editing Theme Colors

Edit `templates/theme-style.toml`:

```toml
[light]
color-scheme = "light"
main-color = "#000000"      # Main text color
dash-color = "#20609f"      # Accent color (headings, links)
code-theme = ""             # Code highlighting theme

[my-custom-theme]
color-scheme = "dark"
main-color = "#e0e0e0"      # Light gray text
dash-color = "#ff6b6b"      # Red accent
code-theme = "tokyo-night.tmTheme"
```

### Color Variables Explained
- `main-color`: Primary text color
- `dash-color`: Accent color for headings, links, borders
- `code-theme`: Syntax highlighting theme for code blocks
- `color-scheme`: `"light"` or `"dark"` (affects browser UI)

### Using Custom Syntax Themes

Place `.tmTheme` files in `templates/` and reference them:

```toml
[my-theme]
code-theme = "my-custom-syntax.tmTheme"
```

Popular syntax themes:
- Monokai
- Dracula
- Nord
- One Dark
- Solarized

---

## Advanced Configuration

### Render Modes

Control how the book is rendered:

```bash
# Dynamic paged rendering (default)
shiroa build --mode dyn-paged

# Static HTML with dynamic frames
shiroa build --mode static-html-dyn-paged

# Fully static HTML
shiroa build --mode static-html
```

### Custom Output Directory

```bash
shiroa build --dest-dir ./my-output/
```

### Custom Workspace Root

If your book is part of a larger Typst workspace:

```bash
shiroa build --workspace /path/to/workspace/
```

### Metadata Inference

```bash
# Strict mode (default) - requires explicit meta labels
shiroa build --meta-source strict

# Outline mode - infers structure from document outline
shiroa build --meta-source outline
```

---

## Project Structure

```
FTQC/
├── book.typ              # Main book configuration
├── ebook.typ             # E-book/PDF configuration
├── sample-page.typ       # Introduction chapter
├── GUIDE.md             # This guide
├── templates/            # Styling and themes
│   ├── page.typ         # Page layout and styling
│   ├── ebook.typ        # E-book template
│   ├── theme-style.toml # Color themes
│   └── tokyo-night.tmTheme  # Code syntax theme
└── dist/                # Generated output (HTML, etc.)
    ├── index.html       # Main entry point
    ├── sample-page.html # Chapter pages
    └── theme/           # CSS and assets
```

---

## Troubleshooting

### Font Not Found Warning
```
warning: unknown font family: my-font
```

**Solution:**
- Ensure the font is installed on your system
- Add font path: `shiroa build --font-path /path/to/fonts/`
- Keep fallback fonts in your font list

### Build Fails with Compilation Error

**Solution:**
- Check Typst syntax in your `.typ` files
- Ensure all chapters referenced in `book.typ` exist
- Run `typst compile sample-page.typ` to test individual files

### Changes Not Reflecting in Browser

**Solution:**
- Hard refresh: `Cmd+Shift+R` (macOS) or `Ctrl+Shift+R` (Windows/Linux)
- Clear browser cache
- Stop and restart `shiroa serve`

### Server Won't Start (Port in Use)

**Solution:**
```bash
# Use a different port
shiroa serve --addr 127.0.0.1:8080
```

---

## Useful Resources

- **Typst Documentation:** https://typst.app/docs
- **Shiroa GitHub:** https://github.com/Myriad-Dreamin/shiroa
- **Typst Community:** https://discord.gg/2uDybryKPe

---

## Quick Reference Commands

```bash
# Build the book
shiroa build

# Start development server
shiroa serve

# Build with custom options
shiroa build --mode static-html --dest-dir ./output/

# Use custom fonts
shiroa build --font-path ~/Fonts/

# View help
shiroa --help
shiroa build --help
shiroa serve --help
```

---

**Happy writing! 📚**
