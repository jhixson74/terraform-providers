module github.com/jhixson74/terraform-providers/kubernetes

go 1.16

require github.com/hashicorp/terraform-provider-kubernetes v1.13.3

replace (
	k8s.io/cli-runtime => k8s.io/cli-runtime v0.19.1
	k8s.io/client-go => k8s.io/client-go v0.19.1
)
