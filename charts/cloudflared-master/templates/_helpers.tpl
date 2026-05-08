{{- define "cloudflared.labels" -}}
app.kubernetes.io/part-of: cloudflared-master
app.kubernetes.io/name: cloudflared-master
{{- end -}}

{{- define "cloudflared.namespace" -}}
{{- .Values.namespace | default "cloudflare-gateway" -}}
{{- end -}}
