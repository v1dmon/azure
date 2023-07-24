MAKEFLAGS += --ignore-errors

include ../../config.mk

BASE_PATH := .
LAKESIDE_COMPOSE_FILE := ./std.yml
DMON_COMPOSE_FILE := ./dmon.yml
LAKESIDE_GITHUB_REPO := https://github.com/microservice-api-patterns/lakesidemutual

help: ## print help and exit
	cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.SILENT: help

clone: ## clone lakeside repository
clone:
	$(call _echo,cloning lakeside repository)
	if [[ ! -d "$(BASE_PATH)/lakesidemutual" ]]; then \
		git clone $(LAKESIDE_GITHUB_REPO) $(BASE_PATH)/lakesidemutual; \
	fi
.PHONY: clone

up:
	$(call _echo,starting cluster lakeside + dmon)
	docker-compose -f $(LAKESIDE_COMPOSE_FILE) -f $(DMON_COMPOSE_FILE) up -d
.PHONY: up

.ONESHELL:
start: clone up ## start cluster lakeside + dmon
.PHONY: start

down:
	$(call _echo,stopping cluster lakeside + dmon)
	docker-compose -f $(LAKESIDE_COMPOSE_FILE) -f $(DMON_COMPOSE_FILE) down
.PHONY: down

stop: down ## stop cluster lakeside + dmon
.PHONY: stop
