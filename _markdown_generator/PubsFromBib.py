#!/usr/bin/env python
# coding: utf-8

# # Publications markdown generator for academicpages
# 
# Takes a set of bibtex of publications and converts them for use with [academicpages.github.io](academicpages.github.io). This is an interactive Jupyter notebook ([see more info here](http://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/what_is_jupyter.html)). 
# 
# The core python code is also in `pubsFromBibs.py`. 
# Run either from the `markdown_generator` folder after replacing updating the publist dictionary with:
# * bib file names
# * specific venue keys based on your bib file preferences
# * any specific pre-text for specific files
# * Collection Name (future feature)

# In[1]:


from pathlib import Path
import pybtex.database.input.bibtex
import pybtex
from datetime import datetime
import re


# In[2]:


project_root = Path("..")


# In[3]:


html_escape_table = {
    "&": "&amp;",
    '"': "&quot;",
    "'": "&apos;"
    }

def html_escape(text):
    """Produce entities within text."""
    return "".join(html_escape_table.get(c,c) for c in text)


# In[4]:


from pybtex.plugin import find_plugin
from pybtex.database import parse_string
from pybtex.backends import markdown
APA = find_plugin('pybtex.style.formatting', 'apa')()
HTML = find_plugin('pybtex.backends', 'html')()
MD = markdown.Backend()

def bib2html(bibliography, exclude_fields=None):
    exclude_fields = exclude_fields or []
    if exclude_fields:
        bibliography = parse_string(bibliography.to_string('bibtex'), 'bibtex')
        for entry in bibliography.entries.values():
            for ef in exclude_fields:
                if ef in entry.fields.__dict__['_dict']:
                    del entry.fields.__dict__['_dict'][ef]
    formattedBib = APA.format_bibliography(bibliography)
    return [text_to_HTML(entry.text) for entry in formattedBib]

def text_to_HTML(text):
    return text.render(HTML).replace('<span class="bibtex-protected">', '').replace('</span>', '')

# def bib2md(bibliography, exclude_fields=None):
#     exclude_fields = exclude_fields or []
#     if exclude_fields:
#         bibliography = parse_string(bibliography.to_string('bibtex'), 'bibtex')
#         for entry in bibliography.entries.values():
#             for ef in exclude_fields:
#                 if ef in entry.fields.__dict__['_dict']:
#                     del entry.fields.__dict__['_dict'][ef]
#     formattedBib = APA.format_bibliography(bibliography)
#     return [entry.text.render(MD).replace('<span class="bibtex-protected">', '').replace('</span>', '') for entry in formattedBib]


# In[5]:


pubs = pybtex.database.parse_file(project_root / 'CV' / 'me.bib')
my_name = 'Thomas Louf'
my_cit_name = 'Louf, T.'

for i, (bib_id, p) in enumerate(pubs.entries.items()):
    yaml_dict = {'collection': 'publications'}
    # add venue logic depending on citation type
    if p.type in ('incollection', 'inproceedings'):
        venue_key = 'booktitle'
    elif p.type == 'article':
        venue_key = 'journal'
        if 'journaltitle' in p.fields:
            p.fields['journal'] = p.fields['journaltitle']
    elif p.type in ['online', 'misc', 'unpublished'] and 'eprinttype' in p.fields:
        venue_key = 'eprinttype'
    else:
        continue
    yaml_dict['type'] = p.type
    venue = p.fields.get(venue_key, '').replace("{", "").replace("}","").replace("\\","")
    yaml_dict['venue'] = html_escape(venue)

    if 'date' in p.fields:
        date = datetime.strptime(p.fields['date'], '%Y-%m-%d')
        pub_year = str(date.year)
        pub_month = datetime.strftime(date, '%m')
        pub_day = str(date.day)
        pub_date = str(date.date())
        p.fields['year'] = pub_year
    else:
        pub_year = p.fields['year'][:4]
        #todo: this hack for month and day needs some cleanup
        pub_month = p.fields.get('month')
        pub_day = p.fields.get('day')
        pub_date = '-'.join([x for x in [pub_year, pub_month, pub_day] if x is not None])

    full_month = ''
    if pub_month is not None:
        if len(pub_month) < 3:
            pub_month = "0" + pub_month
            pub_month = pub_month[-2:]
        elif pub_month not in range(12):
            tmnth = datetime.strptime(pub_month[:3],'%b').tm_mon   
            pub_month = "{:02d}".format(tmnth) 
        else:
            pub_month = str(pub_month)
        full_month = datetime.strftime(datetime.strptime(pub_month, '%m'), '%B')

    if pub_month is None:
        pretty_date = f'{pub_year}'
    elif pub_day is None:
        pretty_date = f'{full_month}, {pub_year}'
    else:
        pretty_date = f'{full_month} {pub_day}, {pub_year}'
    yaml_dict['print_date'] = pretty_date

    pub_title = p.fields['title']
    # strip out {} as needed (some bibtex entries that maintain formatting)
    clean_title = pub_title.replace("{", "").replace("}","").replace("\\","")
    yaml_dict['title'] = html_escape(clean_title)
    
    url_slug = re.sub("\\[.*\\]|[^a-zA-Z0-9_-]", "", clean_title.replace(" ","-")).replace("--","-")
    file_path = project_root / "_publications" / f"{pub_date}-{url_slug}.md"
    # md_filename = (str(pub_date) + "-" + url_slug + ".md").replace("--","-")
    html_filename = file_path.stem
    yaml_dict['permalink'] = '/publications/'  + html_filename
    
    authors = p.persons["author"]
    author_iter = zip(
        [' '.join(a.first_names) for a in authors],
        [' '.join(a.middle_names) for a in authors],
        [' '.join(a.last_names) for a in authors])
    authors = ', '.join([' '.join(a) for a in author_iter])
    authors = text_to_HTML(pybtex.richtext.Text.from_latex(authors))
    start_idx = authors.find(my_name)
    bolded = f"<span class='author_is_me'>{my_name}</span>"
    authors = authors[:start_idx] + bolded + authors[start_idx+len(my_name):]
    yaml_dict['authors'] = authors

    if 'url' in p.fields:
        yaml_dict['paperurl'] = p.fields['url']
    elif 'doi' in p.fields:
        yaml_dict['paperurl'] = f"https://doi.org/{p.fields['doi']}"
    yaml_dict['arxivId'] = p.fields.get('arxivId')

    # Build Citation from text
    citation = bib2html(p, exclude_fields=['month', 'url'])
    yaml_dict['citation'] = re.sub(r'"|[a-z&]{3,5};', '', html_escape(citation))

    # YAML variables
    md = '---\n'
    md += '\n'.join([f'{key}: "{value}"' for key, value in yaml_dict.items() if value])
    md += '\n---'
    # Content
    md += '\n' + text_to_HTML(pybtex.richtext.Text.from_latex(p.fields.get('abstract', '')))

    with open(file_path, 'w') as f:
        print(file_path)
        f.write(md)
    print(f'SUCESSFULLY PARSED {bib_id}: \"', pub_title[:60],"..."*(len(pub_title)>60),"\"")


# In[ ]:




