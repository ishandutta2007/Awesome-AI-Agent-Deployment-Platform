import re

readme_path = r"C:\Users\ishan\Documents\Projects\Awesome-AI-Agent-Deployment-Platform\README.md"
with open(readme_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Add banner at the top
banner_md = "![Awesome AI Agent Deployment Banner](assets/banner.svg)\n\n"
if "assets/banner.svg" not in content:
    content = banner_md + content

# 2. Add emojis and SEO friendly text (simple heuristic adds)
# Enhance headers with emojis and SEO keywords
content = content.replace("## Top AI Agent Deployment Platforms Ecosystem", "## 🚀 Top AI Agent Deployment Platforms Ecosystem")
content = content.replace("## SaaS/Hosted Platforms", "## ☁️ SaaS/Hosted Platforms (Enterprise AI Agents)")
content = content.replace("## Open-Source GitHub Projects", "## 💻 Open-Source GitHub Projects (Self-Hosted AI Agents)")
content = content.replace("### Core Platforms", "### 🎯 Core Platforms")
content = content.replace("### Additional Strong Hosted Options", "### 🌟 Additional Strong Hosted Options")
content = content.replace("## How to Contribute", "## 🤝 How to Contribute")
content = content.replace("## Disclaimer", "## ⚠️ Disclaimer")
# Add some SEO text
content = content.replace("**Curated List of SaaS Products & Open-Source GitHub Projects**", "**Curated List of SaaS Products & Open-Source GitHub Projects for AI Agent Orchestration, Deployment, and Management**")

# 3. Add badges
left_badges = '<a href="https://github.com/ishandutta2007/Awesome-Awesome-Awesome"><img src="https://img.shields.io/badge/Awesome-%E2%9C%94-blueviolet?style=flat-square&logo=github" alt="Awesome"/></a><a href="https://discord.gg/jc4xtF58Ve"><img src="https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord" /></a>'
right_badges = '<a href="https://github.com/ishandutta2007"><img alt="GitHub followers" src="https://img.shields.io/github/followers/ishandutta2007?label=Follow" /></a>'
badges_html = f'<div align="center">\n  {left_badges}\n  {right_badges}\n</div>\n\n'

# Insert badges after the H1 title if not present
if "badge/Awesome" not in content:
    content = re.sub(r'(# Awesome-AI-Agent-Deployment-Platform\n)', r'\1\n' + badges_html, content)

# 4. Add Star History
star_history = """
## 📈 Star History
<div align="center">
<a href="https://www.star-history.com/?repos=ishandutta2007%2FAwesome-AI-Agent-Deployment-Platform&type=date&legend=bottom-right">
<picture>
<source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=ishandutta2007/Awesome-AI-Agent-Deployment-Platform&type=date&theme=dark&legend=bottom-right" />
<source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=ishandutta2007/Awesome-AI-Agent-Deployment-Platform&type=date&legend=bottom-right" />
<img alt="Star History Chart" src="https://api.star-history.com/chart?repos=ishandutta2007/Awesome-AI-Agent-Deployment-Platform&type=date&legend=bottom-right" />
</picture>
</a>
</div>
"""
if "Star History" not in content:
    # Append before Disclaimer or at the bottom
    if "## ⚠️ Disclaimer" in content:
        content = content.replace("## ⚠️ Disclaimer", star_history + "\n## ⚠️ Disclaimer")
    else:
        content += "\n" + star_history

# 5. Replace chartrepos
content = content.replace("chartrepos", "chart?repos")

# 6. Replace awesome link
content = content.replace("https://github.com/sindresorhus/awesome", "https://github.com/ishandutta2007/Awesome-Awesome-Awesome")

with open(readme_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Modifications applied successfully")
