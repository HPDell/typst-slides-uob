#import "slides-uob.typ": *

#show: slides.with(
  title: "Basic Slides Template for Bristol",
  authors: ("Aegon Huke",),
  date: datetime(day: 18, month: 6, year: 2023)
)

= Usage

== Make Pages

=== Headings

#slide[
  ==== Level 1-2 Headings
  
  This template converts headings with levels 1 and 2 to section pages.
  To create section pages like this section, type the following codes:

  ```typ
  = Usage
  == Make Pages
  ```

  ==== Level 3 Headings
  
  The level 3 headings are hidden but will be shown in the following slides.
  The function `#slide` is used to create a slide.
  For example,

  ```typ
  === Headings
  #slide[...]
  ```

  This is to keep the structure clear in the source document.
  
  ==== Level 4 Headings
  
  This is shown like the above line.
]

=== Slide

#slide(subtitle: [Normal and Empty])[
  Use `#slide` function to create a normal slide with the title and footer.
  If a subtitle is needed, use the optional parameter `subtitle` of this function, like:

  ```typ
  #slide(subtitle: [Normal])[...]
  ```

  The whole thing is arranged in a grid.
]

#empty[
  ==== Empty Slides

  This is an empty slides created by `#empty` function, like:

  ```typ
  #empty[...]
  ```
]

== Elements

=== Leaflets

#slide[
  A leaflet is something like this:

  #leaflet(title: [Leaflet])[
    The leaflet looks like the `block` in Beamer.
    As the name `block` has been taken by Typst itself, we use the `leaflet` as its name.
  ]

  Create a leaflet with the following code:

  ```typ
  #leaflet(title: [Some Title])[...]
  ```
]

=== Tables

#slide[
  #grid(
    columns: (1fr, 2fr),
    column-gutter: 1em,
    [
      A table looks like this:
    
      #table(
        columns: 3,
        th[A], th[B], th[C],
        [11], [12], [13],
        [21], [22], [23],
        [31], [32], [33]
      )
    ],
    [
      #set align(top)
      
      Note that write the header cells with the function `#th`, like

      ```typ
      #th[A], #th[B], #th[C]
      ```
    ]
  )
]

= Skills

=== Grid

#slide[
  This is a magic command to arrange your content.

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    leaflet(title: "Logo")[
      #image("UoB_Logo.svg", height: 3cm)
    ],
    leaflet(title: "Notes")[
      - This logo is collected from the official site of the University of Bristol,
      - ...
    ]
  )

  Please find instructions on the documentation of Typst.
]

=== Color

#slide[
  The color `red` is adjusted to #text(fill: red, `rgb(171, 31, 45)`), looks like #text(fill: red, size: 2em, sym.square.filled).

  ```typ
  #text(fill: red, [...])
  ```

  
]

#empty[
  #align(center, text(4em, red, weight: "semibold", [Thank You!]))
]
