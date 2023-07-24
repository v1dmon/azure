MAKEFLAGS += --ignore-errors

include ../../config.mk

BASE_PATH := .
ROBOTSHOP_COMPOSE_FILE := ./std.yml
DMON_COMPOSE_FILE := ./dmon.yml
ROBOTSHOP_GITHUB_REPO := https://github.com/instana/robot-shop.git

help: ## print help and exit
	cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.SILENT: help

clone: ## clone instana/robot-shop repository
	$(call _echo,cloning instana/robot-shop repository)
	if [[ ! -d "$(BASE_PATH)/robot-shop" ]]; then \
		git clone $(ROBOTSHOP_GITHUB_REPO) $(BASE_PATH)/robot-shop; \
	fi
.PHONY: clone

up:
	$(call _echo,starting cluster robotshop + dmon)
	docker-compose -f $(ROBOTSHOP_COMPOSE_FILE) -f $(DMON_COMPOSE_FILE) up -d
.PHONY: up

start: clone up ## start cluster robotshop + dmon
.PHONY: start

down:
	$(call _echo,stopping cluster robotshop + dmon)
	docker-compose -f $(ROBOTSHOP_COMPOSE_FILE) -f $(DMON_COMPOSE_FILE) down
.PHONY: down

stop: down ## stop cluster robotshop + dmon
.PHONY: stop
