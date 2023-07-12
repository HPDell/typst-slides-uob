// Slides template for the University of Bristol
// Author: Aegon Huke

#let red = rgb(171, 31, 45)

#let document-title = state("title", "")
#let in-slide = state("in-slide", false)

#let slides(
  title: "",
  authors: (),
  date: datetime.today(),
  short-title: "",
  body
) = {
  set document(
    title: title,
    author: authors
  )
  set page(
    width: 320mm,
    height: 200mm,
    margin: 0mm
  )

  document-title.update(title)
  
  set par(leading: 0.8em)
  set text(font: "Fira Sans", size: 20pt)
  show math.equation: set text(font: "Libertinus Math")
  show math.equation.where(block: true): set par(leading: 0.5em)
  
  set heading(numbering: "1.1")
  
  show heading.where(level: 1): it => {
    locate(loc => {
      if in-slide.at(loc) {
        none
      } else {
        pagebreak(weak: true)
      
        v(32%)
        
        align(center, [
          #block(
            text(size: 36pt, [Section #counter(heading).display()])
          )
          #block(
            fill: red,
            width: 80%,
            inset: 28pt,
            radius: 8pt,
            above: 1em,
            text(fill: white, size: 42pt, it.body)
          )
        ])
      }
    }) 
  }
  
  show heading.where(level: 2): it => {
    locate(loc => {
      if in-slide.at(loc) {
        none
      } else {
        pagebreak(weak: true)
      
        v(32%)
      
        align(center, [
          #block(
            text(size: 36pt, [Section #locate(
              loc => query(heading.where(level: 1), loc).last().numbering
            )])
          )
          #block(
            fill: red,
            width: 80%,
            inset: 28pt,
            radius: 8pt,
            above: 1em,
            text(fill: white, size: 42pt, locate(
              loc => query(
                selector(heading.where(level: 1)).before(loc), 
                loc
              ).last().body
            ))
          )
          #block(
            width: 80%,
            align(center, text(fill: red, size: 36pt, it.body))
          )
        ])
      }
    })
  }
  
  show heading.where(level: 3): none
  
  show heading.where(level: 4): it => text(
    size: 1.1em,
    fill: red,
    weight: "bold", 
    stack(
      dir: ltr, 
      spacing: 0.2em, 
      image("UoB_Bullet.svg", height: 0.8em),
      it.body)
  )
  
  set list(marker: text(fill: red, size: 1.2em, baseline: -4pt, sym.triangle.filled.r))

  set enum(numbering: n => text(fill: red, weight: "bold", [#n.]))

  set table(
    inset: 0.64em,
    stroke: red,
    fill: (_, row) => if row == 0 { red.lighten(10%) } else {white}
  )

  // Title Page
  grid(
    rows: (1fr, 128pt, 1fr),
    columns: 100%,
    block(
      height: 100%,
      width: 100%,
      inset: (top: 24pt, right: 48pt)
    )[
      #align(right, image("UoB_Logo.svg", height: 48pt))
    ],
    block(
      inset: (left: 48pt, right: 48pt)
    )[
      #align(left + horizon)[
        #set par(leading: 0.6em)
        #set text(fill: red, size: 40pt, weight: "extrabold")
        #title
      ]
    ],
    block(
      height: 100%,
      inset: (left: 48pt, right: 48pt)
    )[
      #text(size: 24pt, authors.join(", "))
      
      #text(size: 20pt, style: "italic", date.display("[day] [month repr:short] [year]"))
    ]
  )

  body
}

#let slide(body, subtitle: []) = {
  in-slide.update(true)
  locate( loc => {
    if counter(page).at(loc).first() > 1 {
      pagebreak(weak: true)
    }
  })
  grid(
    rows: (64pt, 1fr, 28pt),
    columns: (100%),
    gutter: 4pt,
    block(
      height: 100%,
      width: 100%,
      stroke: 0pt,
      fill: red,
      inset: (top: 16pt, bottom: 8pt, left: 48pt, right: 48pt)
    )[
      #if subtitle == [] {
        block(height: 100%, [
          #text(
            size: 36pt,
            weight: "extrabold",
            fill: white,
            locate(loc => query(
              selector(heading.where(level: 3)).before(loc), 
              loc
            ).last().body)
          )
        ])
      } else {
        grid(
          columns: (auto, 1fr),
          column-gutter: 16pt,
          block(height: 100%, [
            #text(
              size: 36pt,
              weight: "extrabold",
              fill: white,
              locate(loc => query(
                selector(heading.where(level: 3)).before(loc), 
                loc
              ).last().body)
            )
          ]),
          block(height: 100%, inset: (top: 4pt), [
            #text(size: 28pt, fill: white, subtitle)
          ])
        )
      }
    ],
    block(
      height: 100%,
      width: 100%,
      inset: (top: 16pt, left: 48pt, right: 48pt, bottom: 16pt)
    )[
      #align(horizon, body)
    ],
    block(
      height: 100%,
      width: 100%,
      stroke: (top: 2pt + red),
      inset: (top: 10pt, left: 48pt, right: 48pt)
    )[
      #set text(size: 12pt, font: "Fira Sans")
      #text(style: "italic", document-title.display())
      #h(1fr) #counter(page).display()
    ]
  )
  in-slide.update(false)
}

#let empty(content) = {
  in-slide.update(true)
  pagebreak(weak: true)
  block(width: 100%, height: 100%, inset: 48pt, align(horizon, [
    #set text(size: 20pt)
    #content
  ]))
  in-slide.update(false)
}

#let leaflet(content, title: []) = {
  grid(
    rows: (auto, auto),
    columns: (auto,),
    block(
      width: 100%,
      fill: red,
      stroke: red,
      inset: 12pt,
      radius: (top-left: 8pt, top-right: 8pt),
      text(fill: white, size: 24pt, weight: "bold", title)
    ),
    block(
      width: 100%,
      stroke: red,
      inset: 12pt,
      radius: (bottom-right: 8pt, bottom-left: 8pt),
      text(content)
    )
  )
}

#let th(content) = text(fill: white, content)