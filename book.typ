
#import "@preview/shiroa:0.2.0": *

#show: book

#book-meta(
  title: "S.P.Q.R. — An Introduction to Fault-Tolerant Quantum Computation",
  // authors: ("Vagnius Itpivius"),
  summary: [
    #prefix-chapter("introduction.typ")[Introduction]
    
    - #chapter("quick-start.typ")[Quick start]
      - #chapter("central-problems.typ")[Central problems]
      - #chapter("example-toric.typ")[A first example: the toric code]
    
    - #chapter("quantum-channels.typ")[Quantum Channels]
  ]
)



// re-export page template
#import "/templates/page.typ": project
#let book-page = project
