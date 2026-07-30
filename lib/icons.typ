#import "@preview/iconify:0.5.3": icon as iconify-icon, provide-icons

/// Must be called once per page, before any `icon(...)` calls, and as part
/// of the actual page content (not just at module import time) --- see
/// `lib/layout.typ`, which does this automatically for every page.
#let load-icons() = provide-icons(
  json("../assets/academicons.json"),
  json("../assets/fa7-brands.json"),
  json("../assets/fa7-regular.json"),
  json("../assets/fa7-solid.json"),
)

#let icon(name, size: 18pt, ..icon-kwargs) = {
  if name == none { return none }
  iconify-icon(name, height: size, width: size, ..icon-kwargs.named())
}
