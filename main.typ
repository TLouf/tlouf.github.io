// ============================================================================
// main.typ — entry point. Compiles to a multi-file website via Typst's
// bundle export target:
//
//   typst compile --features bundle,html --format bundle main.typ dist
//
// or simply:
//
//   ./build.sh
//
// Each `#page(...)` call below emits one HTML file into the bundle. To add
// a new page: write a `#page("newpage.html", ...)[ ... ]` block here, and
// add it to `nav-items` in config.typ.
// ============================================================================

#import "config.typ": intro, site, socials
#import "lib/layout.typ": page
#import "lib/icons.typ": icon
#import "content/CV/teaching.typ": courses

// -- Home ---------------------------------------------------------------

#page("index.html", nav-key: "home", title: [Home])[
  #html.elem("div", attrs: (class: "hero"))[
    #html.elem("div", attrs: (class: "avatar"))[
      #image(site.avatar, alt: site.name)
    ]
    #html.elem("div", attrs: (class: "hero-text"))[
      #html.elem("h2")[#site.name]
      #html.elem("p", attrs: (class: "tagline"))[#site.tagline]
      #html.elem("p", attrs: (class: "affiliation"))[#site.affiliation]
      #html.elem("div", attrs: (class: "social-links"))[
        #for s in socials.values() {
          link(s.url)[#icon(s.at("icon", default: none)) #s.label]
        }
      ]
    ]
  ]
  #intro
]

// -- Publications ---------------------------------------------------------
// Rendered directly from content/CV/me.bib -- add or edit entries
// there and rebuild; nothing here needs to change.

#page(
  "publications.html",
  nav-key: "publications",
  title: [Publications],
  description: "Publications by " + site.name + ".",
)[
  Here's a collection of published works I contributed to, generated from #link("/publications.bib")[this `.bib` file].
  You can also find my articles on my #link(socials.openalex.url)[#socials.openalex.label] or #link(socials.google-scholar.url)[#socials.google-scholar.label] profiles.

  #let works = (
    yaml("content/CV/me.yaml").at("references")
  )
  #let sections = (
    (title: [= Journal articles], types: ("article", "article-journal")),
    (title: [= Book chapters], types: ("chapter", "book")),
    (title: [= Conference proceedings], types: "paper-conference"),
    (title: [= My PhD thesis], types: "thesis"),
  )

  #for sec in sections {
    sec.title

    for work in works {
      if work.at("type", default: "misc") in sec.types {
        cite(label(work.id), form: none)
      }
    }

    bibliography("content/CV/me.bib", title: none, style: "assets/apa-cv.csl")
  }
]


#page(
  "teaching.html",
  nav-key: "teaching",
  title: [Teaching],
  description: "Teaching by " + site.name + ".",
)[
  #html.elem("ul", attrs: (class: "teaching-list"))[
    #for course in courses {
      html.elem("li", attrs: (class: "teaching-item"))[
        = #if "website" in course {
          link(course.website)[#course.title]
        } else {
          course.title
        }

        #html.elem("div", attrs: (class: "teaching-meta"))[
          #html.elem("span", attrs: (class: "badge"))[#course.years]
          #for (i, degree) in course.degrees.enumerate() {
            if "url" in degree {
              link(degree.url)[#degree.name]
            } else {
              degree.name
            }
            if i < course.degrees.len() - 1 {
              [, ]
            }
          }
          , #course.university
        ]

        #course.at("description", default: [])

        #if "repo" in course {
          html.elem("p", attrs: (class: "teaching-meta"))[
            #link(
              "https://github.com/" + site.github-username + "/" + course.repo,
            )[
              Source material
            ]
          ]
        }
      ]
    }
  ]
]

// -- Assets ---------------------------------------------------------------
// Copies static files into the bundle as-is (no compilation). Add more
// `#asset(...)` lines here for anything else you want served verbatim
// (e.g. a CV PDF, extra images).

#asset("favicon.ico", read("assets/favicon.ico", encoding: none))
#asset("CV.pdf", read("content/CV/CV.pdf", encoding: none))
#asset("publications.bib", read("content/CV/me.bib", encoding: none))
