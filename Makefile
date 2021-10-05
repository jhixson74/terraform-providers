SUBDIRS:=	aws azurerm azurestack google ibm ignition ironic kubernetes kubevirt libvirt local openstack ovirt random vsphere terraform

.PHONY: $(SUBDIRS) all clean build terraform go-mod-tidy go-mod-vendor

all:	$(SUBDIRS)
clean:	$(SUBDIRS)
build:	$(SUBDIRS)

go-mod-tidy:	$(SUBDIRS)
go-mod-vendor:	$(SUBDIRS)

$(SUBDIRS):
	@if [ "$(MAKECMDGOALS)" = "go-mod-tidy" ]; then \
		echo "go mod tidy $@"; cd $@ && go mod tidy; \
	elif [ "$(MAKECMDGOALS)" = "go-mod-vendor" ]; then \
		echo "go mod vendor $@"; cd $@ && go mod vendor; \
	elif [ "$(MAKECMDGOALS)" = "build" ] && [ "$@" != "terraform" ]; then \
		cd $@; path=`grep import $@.go|awk '{ print $$2 }'|sed 's|"||g'`; \
		echo "go build -o terraform-provider-$@ ./vendor/$$path"; \
		go build -o terraform-provider-$@ ./vendor/$$path; \
	elif [ "$(MAKECMDGOALS)" = "build" ] && [ "$@" = "terraform" ]; then \
		echo "go build -o terraform ./vendor/github.com/hashicorp/terraform"; \
		cd terraform && go build -o terraform ./vendor/github.com/hashicorp/terraform; \
	elif [ "$(MAKECMDGOALS)" = "clean" ]; then \
		echo "clean $@"; \
		cd $@ && rm -rf vendor; \
		if [ "$@" = "terraform" ]; then rm -f $@; else rm -f terraform-provider-$@; fi \
	fi
