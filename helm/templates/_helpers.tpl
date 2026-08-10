{{/*
Expand the name of the chart.
*/}}
{{- define "django-angular-main.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a fully qualified app name (Release.Name-chart-name).
Capped at 63 chars because Kubernetes DNS limits.
*/}}
{{- define "django-angular-main.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version, used in helm.sh/chart label.
*/}}
{{- define "django-angular-main.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels — attach to EVERY resource.
*/}}
{{- define "django-angular-main.labels" -}}
helm.sh/chart: {{ include "django-angular-main.chart" . }}
{{ include "django-angular-main.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels — used in matchLabels and pod template labels.
MUST remain stable across upgrades (changing breaks selectors).
*/}}
{{- define "django-angular-main.selectorLabels" -}}
app.kubernetes.io/name: {{ include "django-angular-main.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
ServiceAccount name
*/}}
{{- define "django-angular-main.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "django-angular-main.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
