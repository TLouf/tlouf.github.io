// ============================================================================
// lib/layout.typ — shared page shell (header/nav + footer) used by every
// page. Pages only need to provide their own `main` content.
// ============================================================================

#import "../config.typ": footer-note, nav-items, site
#import "icons.typ": load-icons

/// Wrap `body` into a full page and register it as a file in the bundle at
/// `path`. `nav-key` highlights the matching entry in the top navigation.
#let page(path, nav-key: "", title: "", description: none, body) = {
  document(
    path,
    title: if title == "" { site.name } else { site.name + " - " + title },
    description: if description != none { description } else { site.description },
  )[
    #load-icons()
    #html.elem("link", attrs: (rel: "icon", href: "favicon.ico"))
    #html.elem("style")[#read("../assets/tufte.css")]
    #html.elem("style")[#read("../assets/style.css")]
    #html.elem("header", attrs: (class: "site-header"))[
      #html.elem("div", attrs: (class: "header-inner"))[
        #html.elem("a", attrs: (class: "site-name", href: "index.html"))[#site.name]
        #html.elem("nav")[
          #for item in nav-items {
            let attrs = (href: item.href)
            if item.key == nav-key {
              attrs.insert("class", "active")
            }
            if item.at("new-tab", default: false) {
              attrs.insert("target", "_blank")
              attrs.insert("rel", "noopener noreferrer")
            }
            html.elem("a", attrs: attrs)[#item.label]
          }
        ]
      ]
    ]
    #html.elem("main", attrs: (class: "content"))[#body]
    #html.elem("footer")[
      #html.elem("div")[© #datetime.today().year() #site.name]
      #if footer-note != none {
        html.elem("div")[#footer-note]
      }
    ]
  ]
}
