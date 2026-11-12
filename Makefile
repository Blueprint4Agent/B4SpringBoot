SHELL := /bin/bash

BACKEND_DIR ?= src/backend
BACKEND_PORT ?= 8080
GRADLEW ?= ./gradlew
DOCKER_COMPOSE ?= docker compose
DOCKER_COMPOSE_FILE ?= docker/docker-compose.yml
DOCKER_ENV_FILE ?= docker/.env

DB_COMPOSE = $(DOCKER_COMPOSE) --env-file "$(DOCKER_ENV_FILE)" -f "$(DOCKER_COMPOSE_FILE)"

.DEFAULT_GOAL := help

.PHONY: help install build check format test verify ci clean
.PHONY: backend-install backend-build backend-dev backend-check backend-format backend-test
.PHONY: db-init db-up db-down db-status db-logs db-shell db-check db-migrate

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

db-init: ## Create private Docker settings from the example if missing
	@if [ ! -f "$(DOCKER_ENV_FILE)" ]; then \
		cp "$(DOCKER_ENV_FILE).example" "$(DOCKER_ENV_FILE)" && \
		printf 'Created %s; edit database credentials as needed.\n' "$(DOCKER_ENV_FILE)"; \
	fi

db-up: db-init ## Start PostgreSQL and wait until healthy
	$(DB_COMPOSE) config --quiet
	$(DB_COMPOSE) up -d --wait --wait-timeout 60 postgres

db-down: ## Stop database containers and keep database volumes
	$(DB_COMPOSE) down

db-status: ## Show database container status
	$(DB_COMPOSE) ps -a

db-logs: ## Follow PostgreSQL logs
	$(DB_COMPOSE) logs --follow --tail=100 postgres

db-shell: ## Open an interactive PostgreSQL session
	$(DB_COMPOSE) exec postgres sh -ec 'PGPASSWORD="$$POSTGRES_PASSWORD" psql -h 127.0.0.1 -U "$$POSTGRES_USER" -d "$$POSTGRES_DB"'

db-check: ## Check database credentials and run SELECT 1
	$(DB_COMPOSE) exec -T postgres sh -ec 'PGPASSWORD="$$POSTGRES_PASSWORD" psql -X -v ON_ERROR_STOP=1 -h 127.0.0.1 -U "$$POSTGRES_USER" -d "$$POSTGRES_DB" -c "SELECT 1;"'

db-migrate: ## Apply pending Flyway migrations without starting the web server
	cd "$(BACKEND_DIR)" && $(GRADLEW) bootRun --args='--spring.main.web-application-type=none'
