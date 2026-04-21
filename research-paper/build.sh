#!/bin/bash
cd "$(dirname "$0")"

# Header
cat > index.html << 'HEADER'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>The Current State of Generative AI Education in Higher Education</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:Georgia,'Times New Roman',serif;line-height:1.8;color:#222;background:#fff;padding:2rem 1rem}
.paper{max-width:750px;margin:0 auto}
.back{font-family:'Helvetica Neue',Arial,sans-serif;font-size:.85rem;color:#00274C;text-decoration:none;display:inline-block;margin-bottom:2rem}
.back:hover{text-decoration:underline}
h1{font-size:1.7rem;color:#00274C;line-height:1.3;margin-bottom:.5rem;text-align:center}
.authors{text-align:center;font-style:italic;margin-bottom:.25rem;font-size:1rem}
.affiliation{text-align:center;font-size:.9rem;color:#555;margin-bottom:2rem}
.abstract{background:#f5f5f5;border-left:4px solid #00274C;padding:1.25rem 1.5rem;margin:2rem 0;font-size:.95rem}
.abstract strong{font-family:'Helvetica Neue',Arial,sans-serif;font-size:.85rem;text-transform:uppercase;letter-spacing:1px;color:#00274C;display:block;margin-bottom:.5rem}
h2{font-family:'Helvetica Neue',Arial,sans-serif;font-size:1.2rem;color:#00274C;margin:2.5rem 0 1rem;padding-bottom:.3rem;border-bottom:1px solid #ddd}
h3{font-family:'Helvetica Neue',Arial,sans-serif;font-size:1.05rem;color:#333;margin:1.5rem 0 .75rem}
p{margin-bottom:1rem;text-align:justify}
.references{font-size:.88rem;line-height:1.6}
.references p{padding-left:2rem;text-indent:-2rem;margin-bottom:.6rem}
@media print{.back{display:none}.abstract{background:none;border-left:2px solid #000}}
@media(max-width:600px){body{padding:1rem .75rem}h1{font-size:1.4rem}}
</style>
</head>
<body>
<div class="paper">
<a href="../" class="back">← Back to Program Overview</a>
HEADER

# Process markdown to HTML
python3 -c "
import re, sys

with open('paper.md', 'r') as f:
    text = f.read()

# Remove the --- separator
text = text.replace('---', '')

# Extract title
title_match = re.search(r'^# (.+)$', text, re.M)
if title_match:
    print(f'<h1>{title_match.group(1)}</h1>')
    text = text.replace(title_match.group(0), '', 1)

# Extract authors and affiliation
auth_match = re.search(r'\*\*Authors:\*\* (.+)', text)
if auth_match:
    print(f'<p class=\"authors\">{auth_match.group(1)}</p>')
    text = text.replace(auth_match.group(0), '', 1)

aff_match = re.search(r'\*\*Affiliation:\*\* (.+)', text)
if aff_match:
    print(f'<p class=\"affiliation\">{aff_match.group(1)}</p>')
    text = text.replace(aff_match.group(0), '', 1)

in_references = False
in_abstract = False
lines = text.strip().split('\n')
i = 0
while i < len(lines):
    line = lines[i].strip()
    
    if not line:
        i += 1
        continue
    
    # H2
    if line.startswith('## '):
        heading = line[3:]
        if in_abstract:
            print('</div>')
            in_abstract = False
        if 'Abstract' in heading:
            print(f'<div class=\"abstract\"><strong>Abstract</strong>')
            in_abstract = True
        elif 'References' in heading:
            print(f'<h2>{heading}</h2>')
            print('<div class=\"references\">')
            in_references = True
        else:
            print(f'<h2>{heading}</h2>')
        i += 1
        continue
    
    # H3
    if line.startswith('### '):
        heading = line[4:]
        if in_abstract:
            print('</div>')
            in_abstract = False
        print(f'<h3>{heading}</h3>')
        i += 1
        continue
    
    # Paragraph - collect until blank line
    para = []
    while i < len(lines) and lines[i].strip():
        para.append(lines[i].strip())
        i += 1
    
    p = ' '.join(para)
    # Bold
    p = re.sub(r'\*\*(.+?)\*\*', r'<strong>\1</strong>', p)
    # Italic
    p = re.sub(r'\*(.+?)\*', r'<em>\1</em>', p)
    
    print(f'<p>{p}</p>')
    i += 1

if in_abstract:
    print('</div>')
if in_references:
    print('</div>')
" >> index.html

# Footer
cat >> index.html << 'FOOTER'
</div>
</body>
</html>
FOOTER
