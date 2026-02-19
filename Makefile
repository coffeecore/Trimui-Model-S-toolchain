WORKSPACE_DIR := $(shell pwd)/workspace
CONFIG_FILES := $(shell find trimui_config -type f)
EXTRA_FILES := $(shell find extras -type f)

shell: .build
	docker run -it --rm -v $(WORKSPACE_DIR):/home/trimui/workspace trimui-toolchain /bin/bash
.PHONY: shell

.build: Dockerfile *.patch build_toolchain.sh env-setup.sh extra_packages.txt $(CONFIG_FILES) $(EXTRA_FILES)
	docker build -t trimui-toolchain .
	touch .build

.PHONY: clean
clean:
	docker rmi trimui-toolchain
	rm .build
