// ============================================================================
// config.typ — single place to edit your personal / site information.
// Everything here is plain data: strings, content, dictionaries. No Typst
// knowledge beyond basic syntax is required to update it.
// ============================================================================
#import "lib/icons.typ": icon

#let site = (
  name: "Thomas Louf",
  tagline: "Assistant professor of applied maths",
  description: "Personal academic website of Thomas Louf",
  affiliation: "Grupo Interdisciplinar de Sistemas Complejos (GISC), Departamento de
  Matemáticas, Universidad Carlos III de Madrid",
  avatar: "assets/avatar.png",
  email: "tlouf@math.uc3m.es",
  github-username: "tlouf",
)

// The paragraphs of your "About" text on the home page.
#let intro = [
  I joined the GISC and Universidad Carlos III de Madrid as an assistant professor in 2025. Previously, I pursued my PhD in physics of complex systems at the Institute for Cross-Disciplinary Physics and Complex Systems, in Palma. My thesis approached issues in sociolinguistics with a complexity science lens. In 2023, I moved to Trento to work as a postdoctoral researcher at the Fondazione Bruno Kessler. There, I collaborated in the AI4Trust and Bologna Digital Twin projects, still bringing in complexity approaches, but this time to applications in detection of misinformation spread in online social networks, and in urban mobility behaviour, respectively. All in all, my research centers on the mathematical modeling of human behaviour in social interactions.
]


// Social / profile links shown as icons + text on the home page and footer.
// `icon` has the format `file_stem:icon_name`, where the accessible files are the JSON
// files in `assets`.
#let socials = (
  email: (label: "Email", icon: "fa7-regular:envelope", url: "mailto:" + site.email),
  github: (label: "GitHub", icon: "fa7-brands:github", url: "https://github.com/" + site.github-username),
  openalex: (label: "OpenAlex", url: "https://openalex.org/authors/A5043649135"),
  google-scholar: (
    label: "Google Scholar",
    icon: "fa7-brands:google-scholar",
    url: "https://scholar.google.com/citations?user=sh5mm9YAAAAJ&hl=en",
  ),
  bluesky: (label: "Bluesky", icon: "fa7-brands:bluesky", url: "https://bsky.app/profile/tlouf.bsky.social"),
  affiliation: (label: "GISC", icon: "fa7-solid:people-group", url: "https://gisc.uc3m.es/"),
  orcid: (label: "ORCID", icon: "fa7-brands:orcid", url: "https://orcid.org/0000-0002-8785-8063"),
  osf: (label: "OSF", icon: "academicons:osf", url: "https://osf.io/nb6sh"),
)

// Top navigation bar. `key` must be unique; `href` must match the output
// path passed to `page(...)` for that page in main.typ.
#let nav-items = (
  (key: "home", label: "Home", href: "index.html"),
  (key: "publications", label: "Publications", href: "publications.html"),
  (key: "teaching", label: "Teaching", href: "teaching.html"),
  (
    key: "cv",
    label: [CV #icon("fa7-solid:up-right-from-square", size: 0.7em)],
    href: "CV.pdf",
    new-tab: true,
  ),
)

#let footer-note = link(
  "https://github.com/" + site.github-username + "/" + site.github-username + ".github.io",
)[Built with Typst.]
