package main

import data.kubernetes

name := input.metadata.name

deny[msg] {
  input.kind == "Deployment"
  not input.spec.template.spec.securityContext.runAsNonRoot

  msg := "Containers must not run as root"
}

deny[msg] {
  input.kind == "Deployment"
  not input.spec.selector.matchLabels.app

  msg := "Containers must provide app label for pod selectors"
}

deny[msg] {  
  input.kind = "Service"
  input.metadata.name != "none"
  input.spec.type = "NodePort"
  msg = sprintf("The Service[%s] must not be a NodePort. It should be LoadBalancer or ClusterIp", [input.metadata.name])
}

required_deployment_labels {
	input.metadata.labels["app.kubernetes.io/name"]
	input.metadata.labels["app.kubernetes.io/instance"]
	input.metadata.labels["app.kubernetes.io/version"]
	input.metadata.labels["app.kubernetes.io/component"]
	input.metadata.labels["app.kubernetes.io/part-of"]
	input.metadata.labels["app.kubernetes.io/managed-by"]
}

deny[msg] {
	kubernetes.is_deployment
	not required_deployment_labels
	msg = sprintf("%s must include Kubernetes recommended labels: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/#labels", [name])
}
