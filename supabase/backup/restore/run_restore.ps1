param(
  [Parameter(Mandatory = $true)]
  [string]$DatabaseUrl,
  [string]$PsqlPath = "psql",
  [ValidateSet("auto", "psql", "supabase")]
  [string]$Driver = "auto"
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$restoreDir = Join-Path $root "restore"

$schemaFile = Join-Path $restoreDir "01_schema.sql"
$dataFile = Join-Path $restoreDir "02_data.sql"
$postFile = Join-Path $restoreDir "03_post_data.sql"
$verifyFile = Join-Path $restoreDir "verify_restore.sql"

foreach ($f in @($schemaFile, $dataFile, $postFile)) {
  if (-not (Test-Path $f)) {
    throw "Missing restore file: $f. Run prepare_supabase_restore.mjs first."
  }
}

function Invoke-SqlFile {
  param(
    [string]$SqlFile
  )

  $resolvedDriver = $Driver
  if ($resolvedDriver -eq "auto") {
    if (Get-Command $PsqlPath -ErrorAction SilentlyContinue) {
      $resolvedDriver = "psql"
    } else {
      $resolvedDriver = "supabase"
    }
  }

  if ($resolvedDriver -eq "psql") {
    & $PsqlPath "$DatabaseUrl" -v ON_ERROR_STOP=1 -f "$SqlFile"
    if ($LASTEXITCODE -ne 0) {
      throw "psql failed for file: $SqlFile"
    }
    return
  }

  & npx supabase db query --db-url "$DatabaseUrl" --file "$SqlFile"
  if ($LASTEXITCODE -ne 0) {
    throw "supabase db query failed for file: $SqlFile"
  }
}

Write-Host "Applying schema..."
Invoke-SqlFile -SqlFile "$schemaFile"

Write-Host "Applying data..."
Invoke-SqlFile -SqlFile "$dataFile"

Write-Host "Applying post-data objects..."
Invoke-SqlFile -SqlFile "$postFile"

if (Test-Path $verifyFile) {
  Write-Host "Running verification queries..."
  Invoke-SqlFile -SqlFile "$verifyFile"
}

Write-Host "Restore completed."
