# Academic website (Typst bundle prototype)

A small personal academic website built entirely in [Typst](https://typst.app),
using its experimental **bundle** export target to produce a multi-page
static site (`index.html`, `publications.html`, `teaching.html`, plus
assets) from a single `typst compile` invocation. No JavaScript build step,
no Node, no external Typst packages — just the compiler.

Visual style is a restrained, serif, tufte-inspired academic look (in the
spirit of [`tufted`](https://github.com/vsheg/tufted)), reimplemented here
directly with the bundle API rather than `tufted`'s per-page `make` build.

## Requirements

- Typst **≥ 0.15**, with the experimental `bundle` and `html` export
  features (see [Typst's bundle docs](https://typst.app/docs/reference/bundle/)).
  Both are behind feature flags and **not stable** — expect breakage on
  future Typst releases.

## Build

```sh
./build.sh            # one-off build into ./dist
./build.sh --watch     # live-reloading dev server at http://localhost:3000
```

Equivalent to running directly:

```sh
TYPST_FEATURES=bundle,html typst compile --format bundle main.typ dist
```

Then serve/upload the contents of `dist/` anywhere static files are served
(GitHub Pages, Netlify, S3, ...).

## Project layout

```
main.typ                 entry point — one #page(...) call per site page
config.typ                your name, bio, avatar, social links, nav — edit this first
lib/
  layout.typ               shared header/nav/footer page shell
  icons.typ                inline SVG icons for social links
content/
  CV/
    CV.pdf
    me.bib
    teaching.typ
assets/
  avatar.png                 your profile picture (replace this)
  favicon.ico
build.sh
```

## Updating content

**Home page / bio / socials** — edit `config.typ`.

**Profile picture** — replace `assets/avatar.png` with your own image (any
raster format Typst supports: PNG, JPEG, ...) and update `site.avatar` in
`config.typ` if you rename it. It's embedded directly into the HTML as a
data URI, so there's nothing else to wire up.

**Publications** — edit `content/CV/me.bib` directly. Every entry in
the file is rendered, in the citation order determined by the `style:`
argument passed to `bibliography(...)` in `main.typ` (currently `"apa"`;
any [CSL style name or path](https://typst.app/docs/reference/model/bibliography/)
works, e.g. `"ieee"`).

**Teaching** — each course is a dictionary entry in `content/CV/teaching.typ`.

## Extending

- **New page**: add another `#page("newpage.html", ...)[ ... ]` block to
  `main.typ` and an entry in `nav-items` in `config.typ`.
- **New icons**: download a pack from https://ecstrema.github.io/iconify-typst/ and place the JSON in `assets/`.
- **CV / extra files**: use `#asset("cv.pdf", read("content/cv.pdf", encoding: none))`
  in `main.typ` to copy any file into the bundle verbatim.

## Known limitations (prototype status)

- Bundle & HTML export are experimental Typst features; behavior may change
  across Typst versions.
- `<style>`/`<link>` tags are currently emitted in `<body>` rather than
  `<head>`, since bundle export doesn't yet hoist elements to `<head>`.
  This renders correctly in all modern browsers but isn't strictly
  spec-compliant.
