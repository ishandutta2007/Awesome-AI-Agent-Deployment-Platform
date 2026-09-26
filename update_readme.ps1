$readmePath = "C:\Users\ishan\Documents\Projects\Awesome-AI-Agent-Deployment-Platform\README.md"
$content = Get-Content -Raw -Path $readmePath -Encoding UTF8

# 1. Banner
$bannerMd = "![Awesome AI Agent Deployment Banner](assets/banner.svg)`n`n"
if ($content -notmatch "assets/banner.svg") {
    $content = $bannerMd + $content
}

# 2. Emojis and SEO
$content = $content -replace "## Top AI Agent Deployment Platforms Ecosystem", "## 🚀 Top AI Agent Deployment Platforms Ecosystem"
$content = $content -replace "## SaaS/Hosted Platforms", "## ☁️ SaaS/Hosted Platforms (Enterprise AI Agents)"
$content = $content -replace "## Open-Source GitHub Projects", "## 💻 Open-Source GitHub Projects (Self-Hosted AI Agents)"
$content = $content -replace "### Core Platforms", "### 🎯 Core Platforms"
$content = $content -replace "### Additional Strong Hosted Options", "### 🌟 Additional Strong Hosted Options"
$content = $content -replace "## How to Contribute", "## 🤝 How to Contribute"
$content = $content -replace "## Disclaimer", "## ⚠️ Disclaimer"
$content = $content -replace "\*\*Curated List of SaaS Products & Open-Source GitHub Projects\*\*", "**Curated List of SaaS Products & Open-Source GitHub Projects for AI Agent Orchestration, Deployment, and Management**"

# 3. Badges
$leftBadges = '<a href="https://github.com/ishandutta2007/Awesome-Awesome-Awesome"><img src="https://img.shields.io/badge/Awesome-%E2%9C%94-blueviolet?style=flat-square&logo=github" alt="Awesome"/></a><a href="https://discord.gg/jc4xtF58Ve"><img src="https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord" /></a>'
$rightBadges = '<a href="https://github.com/ishandutta2007"><img alt="GitHub followers" src="https://img.shields.io/github/followers/ishandutta2007?label=Follow" /></a>'
$badgesHtml = "<div align=`"center`">`n  $leftBadges`n  $rightBadges`n</div>`n`n"

if ($content -notmatch "badge/Awesome") {
    $content = $content -replace '(# Awesome-AI-Agent-Deployment-Platform\r?\n)', "`$1`n$badgesHtml"
}

# 4. Star history
$starHistory = @"

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
"@

if ($content -notmatch "Star History") {
    $content = $content -replace "## ⚠️ Disclaimer", "$starHistory`n## ⚠️ Disclaimer"
}

# 5. chartrepos -> chart?repos
$content = $content -replace "chartrepos", "chart?repos"

# 6. awesome link
$content = $content -replace "https://github.com/sindresorhus/awesome", "https://github.com/ishandutta2007/Awesome-Awesome-Awesome"

Set-Content -Path $readmePath -Value $content -NoNewline -Encoding UTF8

Write-Host "Updated README successfully!"
