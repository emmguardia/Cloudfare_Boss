# Chiffre cloudflared-master-secrets.yaml avec kubeseal.
# Le fichier en clair reste local (gitignoré), seul le SealedSecret est commité.
#
# Usage :
#   .\scripts\seal-secrets.ps1
#
# Pour pointer vers un autre certificat :
#   $env:CERT = "C:\chemin\vers\pub-cert.pem" ; .\scripts\seal-secrets.ps1

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path $PSScriptRoot -Parent
$SecretsPlain = Join-Path $RepoRoot "charts\cloudflared-master\secrets\cloudflared-master-secrets.yaml"
$SealedTemplate = Join-Path $RepoRoot "charts\cloudflared-master\templates\sealed-secret.yaml"
$Cert = if ($env:CERT) { $env:CERT } else { Join-Path (Split-Path $RepoRoot -Parent) "Clos-De-La-Reine-Argo-Repo\pub-cert.pem" }

if (-not (Test-Path $SecretsPlain)) {
  Write-Error "Fichier non trouvé: $SecretsPlain"
  exit 1
}
if (-not (Test-Path $Cert)) {
  Write-Error "Certificat non trouvé: $Cert"
  Write-Host "Définis `$env:CERT=chemin\vers\pub-cert.pem si besoin"
  exit 1
}

Write-Host "Chiffrement de cloudflared-master-secrets..."
$sealed = Get-Content $SecretsPlain -Raw | kubeseal --format yaml --cert $Cert
$sealed | Set-Content -Path $SealedTemplate -Encoding utf8

Write-Host "sealed-secret.yaml mis à jour"
Write-Host "Fichier plain (ne pas committer): $SecretsPlain"
