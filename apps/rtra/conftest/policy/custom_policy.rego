package main

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
  msg = sprintf("The Service[%s] must not be a NodePort. It should be LoadBalancer or ClusterIp", [input.metadata.name, env])
}
