---
permalink: /
title: "About me"
excerpt: "About me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---

{% assign author = site.author %}

<div class="hidden__avatar">
  <img src="{{ author.avatar | prepend: "/images/" | prepend: base_path }}" alt="{{ author.name }}">
<div>
    <p class="hidden__link"><a href="mailto:{{ author.email }}"><i class="fas fa-fw fa-envelope"></i></a></p>
    <p class="hidden__link"><a href="{{ author.googlescholar }}"><i class="ai ai-google-scholar ai-fw"></i></a></p>
    <p class="hidden__link"><a href="https://github.com/{{ author.github }}"><i class="fab fa-github"></i></a></p>
    <p class="hidden__link"><a href="{{ author.researchgate }}"><i class="fab fa-fw fa-researchgate" aria-hidden="true"></i></a></p>
    <p class="hidden__link"><a href="https://orcid.org/{{ author.orcid }}"><i class="ai ai-orcid ai-fw"></i></a></p>
    <p class="hidden__link"><a href="{{ author.figshare }}"><i class="ai ai-figshare ai-fw"></i></a></p>
    <p class="hidden__link"><a href="{{ author.instituteurl }}"><i class="fa fa-fw fa-university" aria-hidden="true"></i></a></p>
  </div>
  <br>
</div>

Hello, welcome to my personal website (WIP)!