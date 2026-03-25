#import "/book.typ": book-page
#import "@preview/ega-numbering:0.1.0": *
#show: ega-rules.with(level: 0)

#show: book-page.with(title: "Introduction")

= Introduction

#quote(attribution: [David Hume], block: true)[
  Generally speaking, the errors in religion are dangerous; those in philosophy only ridiculous.
]

#quote(attribution: [Vagnius Itpivius], block: true)[
  And those in quantum devices, fortunately, correctable.
]


== Metadata

- Author: Vagnius Itpivius
- Version: -1.0.0 (Incomplete draft)
- Date created: 2026-03-23
- Date updated: #datetime.today().display()

== About this book

#num-par[
This is an online book for fault-tolerant quantum computation.

Given the sheer volume of literature on this topic, a title like 'An Introduction to...' would effectively cause Poincaré's recurrence theorem to fail,
ensuring that once lost, this book would never be found again. 
To add a touch of distinctiveness, the author, Vagnius Itpivius, a Han-Roman physicist from the Ancient world, has opted for a more unique moniker: S.P.Q.R., or Stochastically Perturbed Quantum Registers.
]

#num-par[
The author is trying to follow the following principles in this book:
- Always keep an eye on the experiments. 
  We are to build a quantum computer in the physical world, rather than in a classical computer.
- Intuition comes first, mathematics second.
- Formal mathematics is not avoided, but rather welcomed as long as it makes analysis simple and clear.

That is to say, we will face the complexity of Nature,
seek a physical sense of what we want to do and what we can do,
and abstract a structure for analysis.
For example, readers will see how acoustic optical deflectors (AOD) are used for moving atomic qubits,
as well as how the tensor product of chain complexes is utilized to construct quantum codes.
]

#num-par[
We assume that the reader is familiar with basic notions of qubits, quantum gates and quantum circuits.
For mathematical background, we assume the reader is familiar with linear algebra of finite-dimensional vector spaces,
a little calculus,
and a basic understanding of probability theory (from the standard courses in physics department).
We will introduce any mathematical mechinary beyond these when it is needed.
]

== Structure of the book 

#num-par[
We will begin with a Chapter called "Quick Start",
like many documentations for packages.
In this chapter, we will discuss the purpose and necessity of fault-tolerant quantum computation (FTQC).
Furthermore, we will introduce a simple yet utterly important example of quantum codes: the Toric code.
We will not define what a quantum code is though,
which does not prevent us from understanding how quantum information is protected by this code, at least intuitively.

As a comparison, many old-fashioned books on quantum error correction (QEC) put toric code in the very ending of the book,
from which a modern researcher entering the field will,
after months of hard work,
find themselves standing merely at the entrance of the modern literature, equipped with a bunch of formal theories.
On the contrary, we lead the reader to the entrance right at the entrance of this book.
After reading the "Quick Start" chapter,
the reader will get an intuition on what the FTQC is doing,
and know something about the most widely used quantum code today.
]