# Generate Mixin Resources

With the help of Mixins, we're able to generate alerts and dashboards.
Configuration is done within the `mixin.libsonnet`, which allows us to override the default values.

## Prerequisites

```shell
go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest
brew install jsonnet
jb init
jb install
```

## Generation

### Dashboard

```shell
jsonnet -J vendor -m ../dashboards -e '(import "mixin.libsonnet").grafanaDashboards'
```

### Rules

```shell
jsonnet -J vendor -S -e 'std.manifestYamlDoc((import "mixin.libsonnet").prometheusRules)' > ../../../../../mimir/prd/management/monitoring/ruler/rules.yml
```

### Alerts

```shell
jsonnet -J vendor -S -e 'std.manifestYamlDoc((import "mixin.libsonnet").prometheusAlerts)' > ../../../../../mimir/prd/management/monitoring/ruler/alerts.yml
```
