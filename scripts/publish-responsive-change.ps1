[CmdletBinding()]
param(
  [string]$CommitMessage = "Make homepage responsive"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$expectedRemote = "https://github.com/Mvenda27/opinionweekly"
$publishPaths = @(
  "app/page.module.css",
  "README.md",
  "scripts/publish-responsive-change.ps1"
)

Push-Location $repositoryRoot
try {
  $gitRoot = (& git rev-parse --show-toplevel).Trim()
  if ($LASTEXITCODE -ne 0) {
    throw "Unable to locate the Git repository."
  }
  if ((Resolve-Path $gitRoot).Path -ne $repositoryRoot) {
    throw "This script must run from within its own repository."
  }

  $pushRemote = (& git remote get-url --push origin).Trim()
  if ($LASTEXITCODE -ne 0) {
    throw "The origin push remote is not configured."
  }

  $normalizedRemote = $pushRemote.TrimEnd("/")
  if ($normalizedRemote.EndsWith(".git", [StringComparison]::OrdinalIgnoreCase)) {
    $normalizedRemote = $normalizedRemote.Substring(0, $normalizedRemote.Length - 4)
  }

  $allowedRemotes = @(
    $expectedRemote,
    "git@github.com:Mvenda27/opinionweekly",
    "ssh://git@github.com/Mvenda27/opinionweekly"
  )
  if ($allowedRemotes -inotcontains $normalizedRemote) {
    throw "The origin push remote is '$pushRemote', not the requested opinionweekly repository."
  }

  $branch = (& git branch --show-current).Trim()
  if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($branch)) {
    throw "Cannot publish from a detached HEAD."
  }

  & git diff --cached --quiet
  if ($LASTEXITCODE -ne 0) {
    throw "The Git index already contains staged changes. Commit or unstage them before running this script."
  }

  $responsiveChange = & git status --porcelain -- app/page.module.css
  if ($LASTEXITCODE -ne 0) {
    throw "Unable to inspect the responsive stylesheet."
  }
  if ([string]::IsNullOrWhiteSpace(($responsiveChange -join ""))) {
    throw "No uncommitted responsiveness changes were found in app/page.module.css."
  }

  & git add -- $publishPaths
  if ($LASTEXITCODE -ne 0) {
    throw "Unable to stage the responsiveness changes and publishing script."
  }

  & git commit -m $CommitMessage
  if ($LASTEXITCODE -ne 0) {
    throw "Git commit failed."
  }

  & git push origin $branch
  if ($LASTEXITCODE -ne 0) {
    throw "The commit was created, but pushing to origin failed."
  }
}
finally {
  Pop-Location
}
