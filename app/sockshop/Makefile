MAKEFLAGS += --ignore-errors

include ../../config.mk

BASE_PATH := .
SOCKSHOP_COMPOSE_FILE := ./dns-std.yml
DMON_COMPOSE_FILE := ./dns-std-dmon.yml

help: ## print help and exit
	cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.SILENT: help

weave-up:
	$(call _echo,starting weave)
	if [ -z `command -v weave` ]; then \
		sudo curl -L git.io/weave -o /usr/local/bin/weave; \
		sudo chmod a+x /usr/local/bin/weave; \
	fi
	weave launch
.PHONY: weave-up

scope-up:
	$(call _echo,starting scope)
	if [ -z `command -v scope` ]; then \
		sudo curl -L git.io/scope -o /usr/local/bin/scope; \
		sudo chmod a+x /usr/local/bin/scope; \
	fi
	scope launch
.PHONY: scope-up

.SILENT: up
.PHONY: up
up:
	$(call _echo,starting cluster sockshop + dmon)
	docker-compose -f $(SOCKSHOP_COMPOSE_FILE) -f $(DMON_COMPOSE_FILE) up -d

#start: weave-up scope-up up ## start cluster sockshop + dmon
start: up ## start cluster sockshop + dmon
.PHONY: start

weave-down:
	$(call _echo,stopping weave)
	if [ -z `command -v weave` ]; then \
		weave reset --force; \
		weave stop; \
	fi
.PHONY: weave-down

scope-down:
	$(call _echo,stopping scope)
	if [ -z `command -v scope` ]; then \
		scope stop; \
	fi
.PHONY: scope-down

down:
	$(call _echo,stopping cluster sockshop + dmon)
	docker-compose -f $(SOCKSHOP_COMPOSE_FILE) -f $(DMON_COMPOSE_FILE) down
.PHONY: down

#stop: down scope-down weave-down ## stop cluster sockshop + dmon
stop: down ## stop cluster sockshop + dmon
.PHONY: stop
