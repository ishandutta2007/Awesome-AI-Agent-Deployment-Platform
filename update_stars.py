import re
import json
import urllib.request

readme_path = r"C:\Users\ishan\Documents\Projects\Awesome-AI-Agent-Deployment-Platform\README.md"

with open(readme_path, 'r', encoding='utf-8') as f:
    content = f.read()

# The section to replace is between "## Open-Source GitHub Projects\n\n" and "\n### Additional Strong Open-Source Options"
start_marker = "## Open-Source GitHub Projects\n\n"
end_marker = "\n### Additional Strong Open-Source Options"

start_idx = content.find(start_marker)
end_idx = content.find(end_marker)

if start_idx == -1 or end_idx == -1:
    print("Could not find section")
    exit(1)

section = content[start_idx + len(start_marker):end_idx]

# Pattern for each item: 
# - **[Name](url)**
#   Description
pattern = re.compile(r'- \*\*\[([^\]]+)\]\((https://github\.com/([^/]+)/([^/]+?)(?:/)?)\)\*\*\n\s+([^\n]+)')

items = []
for match in pattern.finditer(section):
    name = match.group(1)
    url = match.group(2)
    owner = match.group(3)
    repo = match.group(4)
    desc = match.group(5)
    
    # fetch stars
    api_url = f"https://api.github.com/repos/{owner}/{repo}"
    try:
        req = urllib.request.Request(api_url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode())
            stars = data.get('stargazers_count', 0)
    except Exception as e:
        print(f"Error fetching {owner}/{repo}: {e}")
        stars = 0
        
    items.append({
        'name': name,
        'url': url,
        'owner': owner,
        'repo': repo,
        'desc': desc,
        'stars': stars,
        'original': match.group(0)
    })

# Sort items by stars descending
items.sort(key=lambda x: x['stars'], reverse=True)

new_section = ""
for item in items:
    # badge url
    badge_url = f"https://img.shields.io/github/stars/{item['owner']}/{item['repo']}?style=social&color=white"
    stargazers_url = f"https://github.com/{item['owner']}/{item['repo']}/stargazers"
    badge_md = f"[![Stars]({badge_url})]({stargazers_url})"
    
    new_section += f"- **[{item['name']}]({item['url']})** {badge_md}\n  {item['desc']}\n"

new_content = content[:start_idx + len(start_marker)] + new_section + content[end_idx:]

with open(readme_path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print("Updated README successfully!")
