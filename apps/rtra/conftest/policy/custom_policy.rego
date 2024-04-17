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

deny[msg] {
  input.kind = "PodDisruptionBudget"
  not input.spec.minAvailable
  msg := "Pod disruption budget should be configured for high availability"
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

#Enforce the use of only approved golden images in Dockerfiles
#Ensure that containers never run as a privileged user
#Ensure that all containers have network policies
#Ensure that the latest vendor updates are always installed in a container
#Ensure that all deployments go to a dedicated namespace with proper technical, business, and security labels
#Ensure that all production deployments have a minimum number of replicas
#Avoid using StatefulSets unless a use case is understood and acknowledged
#Ensure that all pods have readiness and liveliness probes
#Ensure that all pods set resource requirements and limits
#Ensure that all pods emit prometheus metrics
#Ensure pod disruption budgets are in place
#Block apps from using untracked persistent volumes that might contain state
