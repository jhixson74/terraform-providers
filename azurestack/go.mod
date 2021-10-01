module github.com/jhixson74/build-terraform-plugins/azurestack

go 1.16

require github.com/terraform-providers/terraform-provider-azurestack v0.10.0

replace github.com/terraform-providers/terraform-provider-azurestack => github.com/openshift/terraform-provider-azurestack v0.10.0-openshift // Use OpenShift fork
