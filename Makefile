# Check if Docker is installed
DOCKER := $(shell command -v docker 2> /dev/null)

# Check if Podman is installed
PODMAN := $(shell command -v podman 2> /dev/null)

# If neither Docker nor Podman is installed, exit with an error
ifeq (,$(or $(DOCKER),$(PODMAN)))
$(error "Neither Docker nor Podman is installed.")
endif

# If Docker is installed, use it instead of Podman
ifdef DOCKER
CONTAINER_ENGINE := docker
else
CONTAINER_ENGINE := podman
endif

IMAGE_NAME := ghcr.io/cdalvaro/ceph

.PHONY: all help build release quickstart stop purge log

all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build        - build the docker-salt-master image"
	@echo "   2. make release      - build the docker-salt-master image and tag it"

build:
	$(CONTAINER_ENGINE) build --tag=$(IMAGE_NAME):latest . \
		--build-arg=CEPH_VERSION="$(shell cat VERSION)"

release: build
	$(CONTAINER_ENGINE) tag $(IMAGE_NAME):latest $(IMAGE_NAME):v$(shell cat VERSION)
