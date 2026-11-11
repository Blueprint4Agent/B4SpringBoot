SHELL := /bin/bash

BACKEND_DIR ?= src/backend
BACKEND_PORT ?= 8080
GRADLEW ?= ./gradlew

.DEFAULT_GOAL := help

.PHONY: help install build check format test verify ci clean
.PHONY: backend-install backend-build backend-dev backend-check backend-format backend-test

help: ## Show available Make targets
	@awk 'BEGIN {FS = ":.*##"; printf "Available targets:\n"} /^[a-zA-Z0-9_.-]+:.*##/ {printf "  %-28s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: backend-install ## Resolve dependencies and compile application and test sources

build: backend-build ## Check, test, and package the backend

check: backend-check ## Check backend code formatting

format: backend-format ## Format backend code

test: backend-test ## Run backend tests

verify: backend-build ## Verify formatting, tests, and executable JAR packaging

ci: verify ## Run local CI checks

clean: ## Remove backend build artifacts
	cd "$(BACKEND_DIR)" && $(GRADLEW) clean

backend-install: ## Resolve dependencies and compile application and test sources
	cd "$(BACKEND_DIR)" && $(GRADLEW) classes testClasses

backend-build: ## Check, test, and package the backend
	cd "$(BACKEND_DIR)" && $(GRADLEW) build

backend-dev: ## Run the backend development server
	cd "$(BACKEND_DIR)" && $(GRADLEW) bootRun --args='--server.port=$(BACKEND_PORT)'

backend-check: ## Check Java formatting with Spotless
	cd "$(BACKEND_DIR)" && $(GRADLEW) spotlessCheck

backend-format: ## Apply Java formatting with Spotless
	cd "$(BACKEND_DIR)" && $(GRADLEW) spotlessApply

backend-test: ## Run backend tests
	cd "$(BACKEND_DIR)" && $(GRADLEW) test
