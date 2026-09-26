$readmePath = "C:\Users\ishan\Documents\Projects\Awesome-AI-Agent-Deployment-Platform\README.md"
$content = Get-Content -Raw -Path $readmePath

$startMarker = "## Open-Source GitHub Projects"
$endMarker = "### Additional Strong Open-Source Options"

$startIndex = $content.IndexOf($startMarker)
$endIndex = $content.IndexOf($endMarker)

if ($startIndex -eq -1 -or $endIndex -eq -1) {
    Write-Host "Could not find section"
    exit 1
}

$sectionStart = $startIndex + $startMarker.Length
$sectionLength = $endIndex - $sectionStart
$section = $content.Substring($sectionStart, $sectionLength)

$pattern = '(?s)- \*\*\[([^\]]+)\]\(https://github\.com/([^/]+)/([^/)]+?)(?:/)?\)\*\*(.*?)(?=- \*\*\[|\z)'

$matches = [regex]::Matches($section, $pattern)

$items = @()

foreach ($match in $matches) {
    $name = $match.Groups[1].Value
    $owner = $match.Groups[2].Value
    $repo = $match.Groups[3].Value
    $desc = $match.Groups[4].Value.Trim()
    
    # Strip existing badge and description cleanly
    $desc = $desc -replace '\[!\[Stars\].*?\)\s*', ''
    $url = "https://github.com/$owner/$repo"
    
    $apiUrl = "https://api.github.com/repos/$owner/$repo"
    
    $stars = 0
    try {
        $json = curl.exe -k -s -A "Mozilla/5.0" $apiUrl
        $data = $json | ConvertFrom-Json
        if ($data.stargazers_count -ne $null) {
            $stars = $data.stargazers_count
        }
    } catch {
        Write-Host "Error fetching ${owner}/${repo}: $_"
    }
    
    $items += [PSCustomObject]@{
        Name = $name
        Url = $url
        Owner = $owner
        Repo = $repo
        Desc = $desc
        Stars = $stars
    }
}

$sortedItems = $items | Sort-Object Stars -Descending

$newSection = "`r`n`r`n"
foreach ($item in $sortedItems) {
    $badgeUrl = "https://img.shields.io/github/stars/$($item.Owner)/$($item.Repo)?style=social&color=white"
    $stargazersUrl = "https://github.com/$($item.Owner)/$($item.Repo)/stargazers"
    $badgeMd = "[![Stars]($badgeUrl)]($stargazersUrl)"
    
    $newSection += "- **[$($item.Name)]($($item.Url))** $badgeMd`r`n  $($item.Desc)`r`n"
}
$newSection += "`r`n"

$newContent = $content.Substring(0, $sectionStart) + $newSection + $content.Substring($endIndex)

Set-Content -Path $readmePath -Value $newContent -NoNewline -Encoding UTF8

Write-Host "Updated README successfully!"
