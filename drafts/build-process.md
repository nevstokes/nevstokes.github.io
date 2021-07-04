---
title: "Image Build Process"
date: 2020-09-12T16:10:13Z
summary: "Like most other development, having a repeatable, reusable, and automated method for building container images will pay dividends by guaranteeing a consistency of approach and removing human error."
IMAGE_NAMEs: ["images","containers","dev"]
---
{{< quote text="You can't build a great building on a weak foundation." author="Gordon B. Hinckley" >}}

Ensure labels are applied and images are tagging in line with an agreed naming strategy.

Start with some `make` boilerplate that I include.

{{< hilite make >}}
{{< note >}}.PHONY{{< /note >}}: build lint help scan

# Make sure we're using bash
{{< note >}}SHELL{{< /note >}} := /usr/bin/env bash

# Special targets
.DELETE_ON_ERROR:
.SUFFIXES:

# Disable all command echoing without requiring @ prefixes
ifndef {{< note >}}VERBOSE{{< /note >}}
.SILENT:
endif

.DEFAULT_GOAL := help

# Define environment in which we're operating
ifdef CI
ENV = ci
endif

# Default to development
ENV ?= dev

# Inspired by https://suva.sh/posts/well-documented-makefiles/
help: ## Display this help
    awk 'BEGIN { \
        FS = ":.*##"; \
        printf "\nUsage:\n  make <target>\n\n" \
    } \
    /^[a-zA-Z0-9_%-]+:.*?##/ { \
        printf "  %-20s %s\n", $$1, $$2 \
    } \
    /^##@/ { \
        printf "\n%s\n", substr($$0, 5) \
    }' \
    $(MAKEFILE_LIST)
{{< /hilite >}}

1. `make` expects to be creating files; when using targets as tasks they should be added to the `.PHONY` list.
1. Ubuntu will default to `dash` otherwise which can get confusing.
1. Using `make VERBOSE=1 <target>` will still enable us to get more detailed tracing for debugging purposes.

Next we'll define some command variables as per Makefile convention.

{{< hilite make "linenostart=38" >}}
BUILDER ?= $(shell {{< note >}}command -v podman || command -v docker{{< /note >}})
RUNNER ?= $(BUILDER)
RUN := $(RUNNER) --rm -ti
{{< /hilite >}}

1. Attempt to automatically discover a container runtime unless one is specified in the environment.

Some default configuration

{{< hilite make "linenostart=41" >}}
REGISTRY ?= {{< note >}}registry.localhost{{< /note >}}
DOCKERFILE ?= Dockerfile
{{< /hilite >}}

1. Setting a default registry at domain that could never be registered ensures that we don't accidentally push images to Docker Hub. Define the real registry address in the CI environment.

Add version control information variables

{{< hilite make "linenostart=48" >}}
SOURCE_REPO := $(shell git config --get remote.origin.url)
SOURCE_REPO_HTTP := $(subst git@,https://,$(basename $(subst :,/,$(SOURCE_REPO))))

BRANCH_NAME ?= $(shell git rev-parse --abbrev-ref HEAD)
COMMIT_HASH ?= $(shell git rev-parse --short HEAD)

# Derive project name from source repository
PROJECT_NAME := $(notdir $(SOURCE_REPO_HTTP))
{{< /hilite >}}

Good idea for these to mirror whatever's used in your CI solution.

Now define the targets that will perform our build process.

{{< hilite make "linenostart=8" >}}
lint: $(DOCKERFILE) ## Lint the Dockerfile for best practice
    $(RUN) hadolint \
        $@

scan: $(DOCKERFILE) ## Scan the image for vulnerabilities
    $(SNYK) test \
        --container $(IMAGE_NAME)
        --file=$@

build: $(DOCKERFILE) lint ## Build the container image
    $(BUILDER) \
        --build-args \
        --IMAGE_NAME $(IMAGE_NAME) \
        --file $@ \
        .

push: ## Push the image to the registry
if origin REGISTRY
    $(BUILDER) \
        push $(IMAGE_NAME)
{{< /hilite >}}
