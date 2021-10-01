module github.com/jhixson74/build-terraform-plugins/vsphere

go 1.16

require github.com/hashicorp/terraform-provider-vsphere v1.24.3

replace github.com/hashicorp/terraform-provider-vsphere => github.com/openshift/terraform-provider-vsphere v1.24.3-openshift
