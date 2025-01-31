{{/*
Returns standard volumes

Usage:
{{ include "common.volumes" (dict "configmapName" "example-name" "componentName" "example-component-name") }}

Params:
  - configMapName - String - Required. Used to add comfigmap to volumes
  - componentName - String - Required. Used to add component name to volumes

*/}}
{{- define "common.volumes" -}}
- configMap:
    defaultMode: 420
    name: cluster-cm
  name: cluster-cm
- configMap:
    defaultMode: 420
    name: {{ .configmapName }}
  name: replace-cm
- configMap:
    defaultMode: 420
    name: status-cm
  name: status-cm
- hostPath:
    path: "/var/log/mapr/{{ .componentName }}"
    type: DirectoryOrCreate
  name: logs
- hostPath:
    path: "/var/log/mapr/cores"
    type: DirectoryOrCreate
  name: cores
- hostPath:
    path: "/var/log/mapr/podinfo"
    type: DirectoryOrCreate
  name: podinfo
- configMap:
    defaultMode: 420
    name: ldapclient-cm
  name: ldap-cm
- name: sssd-secrets
  secret:
    defaultMode: 420
    secretName: sssd
- name: ssh-secrets
  secret:
    defaultMode: 420
    secretName: ssh
{{- end }}

{{- define "common.security.volumes" -}}
- name: client-secrets
  secret:
    defaultMode: 420
    secretName: client
- name: server-secrets
  secret:
    defaultMode: 420
    secretName: server
{{- end }}
