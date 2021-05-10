---
layout: archive
title: "Publications"
permalink: /publications/
author_profile: true
---

{% assign author = site.author %}
{% if author.googlescholar %}
  You can also find my articles on <a href="{{author.googlescholar}}">my Google Scholar profile</a>.
{% endif %}

{% include base_path %}
<h2 itemprop="headline">
  Journal articles
</h2>
{% for post in site.publications reversed %}
  {% if post.type == "article" %}
    {% include archive-single-publication.html %}
  {% endif %}
  ---
{% endfor %}


<h2 itemprop="headline">
  Preprints
</h2>
{% for post in site.publications reversed %}
  {% if post.type == "unpublished" %}
    {% include archive-single-publication.html %}
  {% endif %}
  ---
{% endfor %}


<h2 itemprop="headline">
  Conference proceedings
</h2>
{% for post in site.publications reversed %}
  {% if post.type == "inproceedings" %}
    {% include archive-single-publication.html %}
  {% endif %}
  ---
{% endfor %}