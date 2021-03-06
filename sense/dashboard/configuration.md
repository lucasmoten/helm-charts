# sense/dashboard Configuration Options

Autogenerated by `gen-docs.py` at 2020-05-12 15:16:11

### Global Configuration

|             Parameter              |Description|          Default           |
|------------------------------------|-----------|----------------------------|
|global.image_pull_secret            |           |{{ .Values.global.image_pull_secret }}               |
|global.environment                  |           |openshift                   |
|global.zone                         |           |zone-default-zone           |
|global.consul.enabled               |           |False                       |
|global.consul.host                  |           |                            |
|global.consul.port                  |           |                        8500|
|global.control.port                 |           |                       50000|
|global.control.cluster_label        |           |greymatter.io/control       |
|global.control.additional_namespaces|           |                            |
|global.spire.enabled                |           |False                       |
|global.spire.trust_domain           |           |quickstart.greymatter.io    |
|global.spire.path                   |           |/run/spire/socket/agent.sock|
|global.sidecar.version              |           |1.4.0                       |

### Sidecar Configuration

|                 Parameter                  |Description|                                                 Default                                                  |
|--------------------------------------------|-----------|----------------------------------------------------------------------------------------------------------|
|sidecar_dashboard.version                   |           |{{- $.Values.global.sidecar.version \| default "latest" }}                                                 |
|sidecar_dashboard.image                     |           |docker.production.deciphernow.com/deciphernow/gm-proxy:{{ tpl $.Values.sidecar_dashboard.version $ }} |
|sidecar_dashboard.port                      |           |                                                                                                     10808|
|sidecar_dashboard.metrics_port              |           |                                                                                                      8081|
|sidecar_dashboard.secret.enabled            |           |True                                                                                                      |
|sidecar_dashboard.secret.secret_name        |           |sidecar-certs                                                                                             |
|sidecar_dashboard.secret.mount_point        |           |/etc/proxy/tls/sidecar                                                                                    |
|sidecar_dashboard.secret.secret_keys.ca     |           |ca.crt                                                                                                    |
|sidecar_dashboard.secret.secret_keys.cert   |           |server.crt                                                                                                |
|sidecar_dashboard.secret.secret_keys.key    |           |server.key                                                                                                |
|sidecar_dashboard.envvars.xds_cluster.type  |           |value                                                                                                     |
|sidecar_dashboard.envvars.xds_cluster.value |           |{{ .Values.dashboard.name }}                                                                              |
|sidecar_dashboard.image_pull_policy         |           |IfNotPresent                                                                                              |
|sidecar_dashboard.resources.limits.cpu      |           |200m                                                                                                      |
|sidecar_dashboard.resources.limits.memory   |           |512Mi                                                                                                     |
|sidecar_dashboard.resources.requests.cpu    |           |100m                                                                                                      |
|sidecar_dashboard.resources.requests.memory |           |128Mi                                                                                                     |
|sidecar_prometheus.version                  |           |{{- $.Values.global.sidecar.version \| default "latest" }}                                                 |
|sidecar_prometheus.image                    |           |docker.production.deciphernow.com/deciphernow/gm-proxy:{{ tpl $.Values.sidecar_prometheus.version $ }}|
|sidecar_prometheus.port                     |           |                                                                                                     10808|
|sidecar_prometheus.metrics_port             |           |                                                                                                      8081|
|sidecar_prometheus.secret.enabled           |           |True                                                                                                      |
|sidecar_prometheus.secret.secret_name       |           |sidecar-certs                                                                                             |
|sidecar_prometheus.secret.mount_point       |           |/etc/proxy/tls/sidecar                                                                                    |
|sidecar_prometheus.secret.secret_keys.ca    |           |ca.crt                                                                                                    |
|sidecar_prometheus.secret.secret_keys.cert  |           |server.crt                                                                                                |
|sidecar_prometheus.secret.secret_keys.key   |           |server.key                                                                                                |
|sidecar_prometheus.envvars.xds_cluster.type |           |value                                                                                                     |
|sidecar_prometheus.envvars.xds_cluster.value|           |{{ .Values.prometheus.name }}                                                                             |
|sidecar_prometheus.image_pull_policy        |           |IfNotPresent                                                                                              |
|sidecar_prometheus.resources.limits.cpu     |           |200m                                                                                                      |
|sidecar_prometheus.resources.limits.memory  |           |512Mi                                                                                                     |
|sidecar_prometheus.resources.requests.cpu   |           |100m                                                                                                      |
|sidecar_prometheus.resources.requests.memory|           |128Mi                                                                                                     |

