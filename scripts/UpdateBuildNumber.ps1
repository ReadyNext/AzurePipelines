# Depends on the CalculateSemVer.ps1 script. Make sure it is executed first!
$semver = $env:SEMVER_CURRENT
$semverMajor = $env:SEMVER_MAJOR
$semverMinor = $env:SEMVER_MINOR
$semverPatch = $env:SEMVER_PATCH
$semverLabel = $env:SEMVER_LABEL
$semverMetadata = $env:SEMVER_METADATA

$gitCommitHash = $env:BUILD_SOURCEVERSION.Substring(0, 7)
$gitBranchName = $env:BUILD_SOURCEBRANCHNAME
$buildId = $env:BUILD_BUILDID

$buildNumber = [System.String]::Concat($semverMajor, ".", $semverMinor, ".", $semverPatch)


if ([System.String]::IsNullOrWhiteSpace($semverLabel)) {
    $semverLabel = $gitCommitHash
}

else {
    $semverLabel = [System.String]::Concat($semverLabel, ".", $gitCommitHash)
}

if ([System.String]::IsNullOrWhiteSpace($semverMetadata)) {
    $semverMetadata = $buildId
}

else {
    $semverMetadata = [System.String]::Concat($semverMetadata, ".", $buildId)
}

if ($gitBranchName -eq "master") {
    $buildNumber = [System.Stirng]::Concat($buildNumber, "-", $semverLabel)
}

$buildNumber = [System.String]::Concat($buildNumber, "+", $semverMetadata)

Write-Host ("##vso[task.setvariable variable=SemVer.BuildVersion]" + $buildNumber)
Write-Host "##vso[build.updatebuildnumber]$buildNumber"