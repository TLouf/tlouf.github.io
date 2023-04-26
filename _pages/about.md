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
<!-- This is what will be shown when shrinking the view: only the icons -->
<div class="hidden__avatar">
  <img src="{{ author.avatar | prepend: "/images/" | prepend: base_path }}" alt="{{ author.name }}">
<div>
  {% if author.email %}
    <p class="hidden__link"><a href="mailto:{{ author.email }}"><i class="fas fa-fw fa-envelope"></i></a></p>
  {% endif %}
  {% if author.mastodon %}
    <p class="hidden__link"><a rel="me" href="{{ author.mastodon }}"><i class="fab fa-fw fa-mastodon" aria-hidden="true"></i></a></p>
  {% endif %}
  {% if author.twitter %}
    <p class="hidden__link"><a href="https://twitter.com/{{ author.twitter }}"><i class="fab fa-fw fa-twitter-square" aria-hidden="true"></i></a></p>
  {% endif %}
  {% if author.uri %}
    <p class="hidden__link"><a href="{{ author.uri }}"><i class="fas fa-fw fa-link" aria-hidden="true"></i></a></p>
  {% endif %}
  {% if author.googlescholar %}
    <p class="hidden__link"><a href="{{ author.googlescholar }}"><i class="ai ai-google-scholar ai-fw"></i></a></p>
  {% endif %}
  {% if author.github %}
    <p class="hidden__link"><a href="https://github.com/{{ author.github }}"><i class="fab fa-github"></i></a></p>
  {% endif %}
  {% if author.researchgate %}
    <p class="hidden__link"><a href="{{ author.researchgate }}"><i class="fab fa-fw fa-researchgate" aria-hidden="true"></i></a></p>
  {% endif %}
  {% if author.orcid %}
    <p class="hidden__link"><a href="https://orcid.org/{{ author.orcid }}"><i class="ai ai-orcid ai-fw"></i></a></p>
  {% endif %}
  {% if author.osf %}
    <p class="hidden__link"><a href="{{ author.osf }}"><i class="ai ai-osf ai-fw"></i></a></p>
  {% endif %}
  {% if author.figshare %}
    <p class="hidden__link"><a href="{{ author.figshare }}"><i class="ai ai-figshare ai-fw"></i></a></p>
  {% endif %}
  {% if author.instituteurl %}
    <p class="hidden__link"><a href="{{ author.instituteurl }}"><i class="fa fa-fw fa-university" aria-hidden="true"></i></a></p>
  {% endif %}
  </div>
  <br>
</div>

Hello, welcome to my personal website (WIP)!
