$tags = git tag --sort=-v:refname
$currentTag = "v1.0.0"

if ($null -ne $tags) {
    $currentTag = $tags.Split('\n')[0].Trim()
}

if ($currentTag.StartsWith("v")) {
    $currentTag = $currentTag.Substring(1)
}

Write-Host ("##vso[task.setvariable variable=SemVer.Current]" + $currentTag)

$semverRegEx = New-Object System.Text.RegularExpressions.Regex -ArgumentList "v?(\d+)\.(\d+)\.(\d+)-?([\w\.]*)\+?(.*)"
$semverMatch = $semverRegEx.Match($currentTag)

$major = $semverMatch.Groups[1]
$minor = $semverMatch.Groups[2]
$patch = $semverMatch.Groups[3]
$label = ""
$metadata = ""

if ($semverMatch.Groups.Count -gt 4) {
    $label = $semverMatch.Groups[5]
}

if ($semverMatch.Groups.Count -gt 5) {
    $metadata = $semverMatch.Groups[6]
}

Write-Host ("##vso[task.setvariable variable=SemVer.Major]" + $major)
Write-Host ("##vso[task.setvariable variable=SemVer.Minor]" + $minor)
Write-Host ("##vso[task.setvariable variable=SemVer.Patch]" + $patch)
Write-Host ("##vso[task.setvariable variable=SemVer.Label]" + $label)
Write-Host ("##vso[task.setvariable variable=SemVer.Metadata]" + $metadata)