SUBDIRS:=	aws azurerm azurestack google ibm ignition ironic kubernetes kubevirt libvirt local openstack ovirt random vsphere

GO_MOD_TIDY_TARGETS:=	$(foreach DIR,$(SUBDIRS), $(subst $(DIR),go-mod-tidy.$(DIR),$(DIR)))
GO_MOD_VENDOR_TARGETS:=	$(foreach DIR,$(SUBDIRS), $(subst $(DIR),go-mod-vendor.$(DIR),$(DIR)))
GO_BUILD_TARGETS:=	$(foreach DIR,$(SUBDIRS), $(subst $(DIR),go-build.$(DIR),$(DIR)))
GO_CLEAN_TARGETS:=	$(foreach DIR,$(SUBDIRS), $(subst $(DIR),go-clean.$(DIR),$(DIR)))


.PHONY: all
all: go-mod-tidy go-mod-tidy-terraform go-mod-vendor go-mod-vendor-terraform go-build go-build-terraform

.PHONY: go-mod-tidy
go-mod-tidy: $(GO_MOD_TIDY_TARGETS)
$(GO_MOD_TIDY_TARGETS)::
	cd $(subst go-mod-tidy.,,$@) && go mod tidy

.PHONY: go-mod-vendor
go-mod-vendor: $(GO_MOD_VENDOR_TARGETS)
$(GO_MOD_VENDOR_TARGETS)::
	cd $(subst go-mod-vendor.,,$@) && go mod vendor

.PHONY: go-build
go-build: $(GO_BUILD_TARGETS)
$(GO_BUILD_TARGETS)::
	dir=$(subst go-build.,,$@); cd $$dir; \
	path=`grep import $$dir.go|awk '{ print $$2 }'|sed 's|"||g'`; \
	go build -o terraform-provider-$$dir ./vendor/$$path; 

.PHONY: go-clean
go-clean: $(GO_CLEAN_TARGETS)
$(GO_CLEAN_TARGETS)::
	dir=$(subst go-clean.,,$@); cd $$dir && rm -rf vendor && rm -f terraform-provider-$$dir

.PHONY: clean
clean: go-clean go-clean-terraform

.PHONY: go-mod-tidy-terraform
go-mod-tidy-terraform::
	cd terraform && go mod tidy

.PHONY: go-mod-vendor-terraform
go-mod-vendor-terraform::
	cd terraform && go mod vendor

.PHONY: go-build-terraform
go-build-terraform::
	echo "go build -o terraform ./vendor/github.com/hashicorp/terraform"; \
	cd terraform && go build -o terraform ./vendor/github.com/hashicorp/terraform

.PHONY: go-clean-terraform
go-clean-terraform:
	cd terraform && rm -rf vendor && rm -f terraform
