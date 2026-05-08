# Security

## Secrets

Le token du tunnel Cloudflare est stocké uniquement chiffré via Bitnami SealedSecrets
(`charts/cloudflared-master/templates/sealed-secret.yaml`).

Le fichier en clair `charts/cloudflared-master/secrets/cloudflared-master-secrets.yaml`
est gitignoré et ne doit **jamais** être commité. La CI (`.github/workflows/helm-lint.yml`)
échoue si un Secret en clair ou un token Cloudflare nu est détecté dans le repo.

## Rotation

Pour changer le token tunnel :

1. Récupère le nouveau token dans le dashboard Cloudflare Zero Trust.
2. Remplace la valeur de `tunnel-token` dans `charts/cloudflared-master/secrets/cloudflared-master-secrets.yaml`.
3. Lance `.\scripts\seal-secrets.ps1` pour régénérer le SealedSecret.
4. Commit + push : ArgoCD redéploie automatiquement.

## Reporting

Pour signaler une vulnérabilité, ouvre une issue privée sur le repo ou contacte le mainteneur.
