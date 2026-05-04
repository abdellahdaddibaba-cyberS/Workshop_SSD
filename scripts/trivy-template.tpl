{{- range . }}
Target: {{ .Target }}
Type: {{ .Type }}
===========================================
{{- range .Vulnerabilities }}
Vulnerability: {{ .VulnerabilityID }}
Severity:      {{ .Severity }}
Package:       {{ .PkgName }}
Installed:     {{ .InstalledVersion }}
Fixed Version: {{ .FixedVersion }}
Title:         {{ .Title }}
Link:          {{ .PrimaryURL }}
-------------------------------------------
{{- end }}
{{- end }}
