local kubernetes = import "kubernetes-mixin/mixin.libsonnet";
local kubestatemetrics = import "kube-state-metrics-mixin/mixin.libsonnet";
local nodexporter = import "node-mixin/mixin.libsonnet";
local certmanager = import "cert-manager-mixin/mixin.libsonnet";
local mimir = import "mimir-mixin/mixin.libsonnet";
local tempo = import "tempo-mixin/mixin.libsonnet";

local ignore_rule_groups = [
  'kube-apiserver-burnrate.rules',
  'kube-apiserver-histogram.rules',
  'kube-apiserver-availability.rules',
  'kube-scheduler.rules'
];

local ignore_alert_groups = [
  'kube-apiserver-slos',
  'kubernetes-system-apiserver',
  'kubernetes-system-scheduler',
  'kubernetes-system-controller-manager',
  'kubernetes-system-kube-proxy'
];

local result = kubernetes {
  _config+:: {
    datasourceName: "mimir",
    cadvisorSelector: 'job="kubelet"',
    kubeStateMetricsSelector: 'job="kube-state-metrics"',
    nodeExporterSelector: 'job="prometheus-node-exporter"',
    showMultiCluster: true,
  },
}
+tempo {}
+kubestatemetrics{}
+nodexporter{
  _config+:: {
    showMultiCluster: true,
    nodeExporterSelector: 'job="prometheus-node-exporter"',
  }
}
+certmanager {};
+mimir{};

// Filter to remove unwanted groups
result {
  prometheusRules+:: {
    groups: std.filter(
      function(group)
        std.count(ignore_rule_groups, group.name) == 0,
      super.groups
    ),
  },
  prometheusAlerts+:: {
    groups: std.filter(
      function(group)
        std.count(ignore_alert_groups, group.name) == 0,
      super.groups
    ),
  },
}
