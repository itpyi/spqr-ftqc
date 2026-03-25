# FTQC Book - Chapter Structure

[![Deploy to GitHub Pages](https://github.com/itpyi/spqr-ftqc/actions/workflows/deploy.yml/badge.svg)](https://github.com/itpyi/spqr-ftqc/actions/workflows/deploy.yml)

**📚 Live Site:** [http://itpyi.site/spqr-ftqc/](http://itpyi.site/spqr-ftqc/)

This book contains template chapters demonstrating nested structure in Shiroa/Typst.

## Current Structure

### 1. Introduction
**File**: `sample-page.typ`  
Welcome to the FTQC notes and overview of the book.

### 2. Quick Start (Parent Section)
This section groups foundational topics together.

#### 2.1 Overview
**File**: `quick-start.typ`  
Introduction to the Quick Start section, prerequisites, and goals.

#### 2.2 Quantum Algorithms
**File**: `quantum-algorithms.typ`  
- Basic quantum circuits
- Overview of key quantum algorithms (Deutsch-Jozsa, Grover, Shor)
- Error sensitivity in quantum algorithms
- Why error correction is needed

#### 2.3 Hardware Errors
**File**: `hardware-errors.typ`  
- Types of quantum errors (bit-flip, phase-flip, depolarizing, etc.)
- Error sources in different platforms (superconducting, trapped ions, etc.)
- Error rates and modeling
- Error mitigation vs. error correction
- Quantum threshold theorem

### 3. Quantum Channels
**File**: `quantum-channels.typ`  
- Mathematical framework for describing quantum noise
- Kraus representation
- Common quantum channels (bit-flip, phase-flip, depolarizing, amplitude/phase damping)
- Multi-qubit channels
- Channel fidelity and diamond norm
- Applications in FTQC

## File Overview

```
FTQC/
├── book.typ                    # Main book configuration with chapter structure
├── sample-page.typ            # Introduction chapter
├── quick-start.typ            # Quick Start overview (parent of nested chapters)
├── quantum-algorithms.typ     # Quantum Algorithms chapter (nested under Quick Start)
├── hardware-errors.typ        # Hardware Errors chapter (nested under Quick Start)
├── quantum-channels.typ       # Quantum Channels chapter (top-level)
├── GUIDE.md                   # Comprehensive customization guide
├── README.md                  # This file
├── templates/                 # Styling and themes
└── dist/                      # Generated HTML output
```

## Adding More Chapters

### Top-level Chapter
1. Create new `.typ` file (e.g., `error-correction.typ`)
2. Add to `book.typ`:
   ```typst
   #prefix-chapter("error-correction.typ")[Quantum Error Correction]
   ```

### Nested Chapter
1. Create new `.typ` file (e.g., `stabilizer-codes.typ`)
2. Add under a section header in `book.typ`:
   ```typst
   = Error Correction
   #prefix-chapter("error-correction.typ")[Introduction]
   #prefix-chapter("stabilizer-codes.typ")[Stabilizer Codes]
   #prefix-chapter("surface-codes.typ")[Surface Codes]
   ```

## Building and Deployment

### Local Development

```bash
# Build the book
shiroa build

# Serve with auto-reload (recommended)
./watch-and-serve.sh

# OR: Serve without auto-reload (manual rebuild required)
shiroa serve

# View output
open dist/index.html
```

**Note:** `shiroa serve` does not include file watching. Use `./watch-and-serve.sh` for automatic rebuilds on file changes.

### Automated Deployment

This book is automatically deployed to GitHub Pages when changes are pushed to the `main` branch:

- **Live URL:** [http://itpyi.site/spqr-ftqc/](http://itpyi.site/spqr-ftqc/)
- **Build Status:** Check the [Actions tab](https://github.com/itpyi/spqr-ftqc/actions)
- **Build Time:** Approximately 4-5 minutes per deployment

The deployment workflow:
1. Installs Rust and Shiroa v0.3.0
2. Builds the book with `shiroa build`
3. Deploys the `dist/` directory to GitHub Pages

To update the live site, simply push your changes to the `main` branch.

## Next Steps

1. Fill in content for existing chapters
2. Add more chapters as needed
3. Customize fonts and themes (see GUIDE.md)
4. Add mathematical proofs and diagrams
5. Include references and citations

## Template Content

The current chapters contain template content demonstrating:
- Typst syntax for headings, lists, code blocks
- Mathematical notation
- Tables
- Nested structure
- Cross-references

Feel free to replace this template content with your actual FTQC notes!

---

For detailed instructions on customization, fonts, themes, and more, see **GUIDE.md**.
