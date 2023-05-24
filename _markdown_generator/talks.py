#!/usr/bin/env python
# coding: utf-8

# # Talks markdown generator for academicpages
# 
# Takes a JSON of talks with metadata and converts them for use with [academicpages.github.io](academicpages.github.io). This is an interactive Jupyter notebook ([see more info here](http://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/what_is_jupyter.html)). The core python code is also in `talks.py`. Run either from the `markdown_generator` folder after replacing `talks.json` with one containing your data.

# In[27]:


from pathlib import Path
import re

import pandas as pd


# In[28]:


project_root = Path("..")


# ## Import json

# In[29]:


talks = pd.read_json(project_root / "CV" / "talks.json", orient="records")
talks


# ## Escape special characters
# 
# YAML is very picky about how it takes a valid string, so we are replacing single and double quotes (and ampersands) with their HTML encoded equivilents. This makes them look not so readable in raw format, but they are parsed and rendered nicely.

# In[8]:


html_escape_table = {
    "&": "&amp;",
    '"': "&quot;",
    "'": "&apos;"
    }

def html_escape(text):
    if type(text) is str:
        return "".join(html_escape_table.get(c,c) for c in text)
    else:
        return "False"


# ## Creating the markdown files

# In[31]:


loc_dict = {}

for row, item in talks.iterrows():
    clean_title = item.title.replace("{", "").replace("}","").replace("\\","")
    url_slug = re.sub("\\[.*\\]|[^a-zA-Z0-9_-]", "", clean_title.replace(" ","-")).replace("--","-")
    date = str(item.date.date())
    file_path = project_root / "_talks" / f"{date}-{url_slug}.md"
    html_filename = file_path.stem

    md = "---\ntitle: \""   + clean_title + '"\n'
    md += "collection: talks" + "\n"
    md += "date: " + date + "\n"

    if "type" in item:
        md += 'type: "' + item.type + '"\n'
    else:
        md += 'type: "Talk"\n'

    md += "permalink: /talks/" + html_filename + "\n"
    
    if "venue" in item:
        md += 'venue: "' + item.venue + '"\n'

    if "location" in item:
        md += 'location: "' + str(item.location) + '"\n'

    if "venueurl" in item:
        md += 'venueurl: "' + item.venueurl + '"\n'
        
    md += "---\n"

    if "description" in item:
        md += "\n" + html_escape(item.description) + "\n"

    with open(file_path, 'w') as f:
        print(file_path)
        f.write(md)


# In[ ]:




