MAKEFLAGS += --no-print-directory

include config.mk

help:
	grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\), \(.*\)/\1, \2\t\3/' | expand -t30
.SILENT: help
.PHONY: help # h, print help and exit

h: help

# ----- GIT -----

# ----- COMBOS -----

clean: stop-robotshop stop-sockshop stop-lakeside clean-dmon-image
.PHONY: clean # rm, combo :: clean all

rm: clean

# ----- TOOLS (build) -----

build-dmon:
	$(call _echo,compiling dmon docker binary)
	# $(MAKE) -C $(dmon) clean install
.PHONY: build-dmon # cd, compile dmon binary

cd: build-dmon

build-dmon-image:
	$(call _echo,building dmon docker image)
	# $(MAKE) -C $(dmon) clean genimage
.PHONY: build-dmon-image # cid, build dmon docker image

cid: build-dmon-image

build-wgen:
	$(call _echo,compiling wgen binary)
	# $(MAKE) -C $(wgen) clean install
.PHONY: build-wgen # cw, compile wgen binary

cw: build-wgen

build-flow:
	$(call _echo,compiling flow binary)
	# $(MAKE) -C $(flow) clean install
.PHONY: build-flow # cf, compile flow binary

cf: build-flow

# ----- TOOLS (clean) -----

clean-dmon:
	$(call _echo,removing dmon docker binary)
	# $(MAKE) -C $(dmon) clean
.PHONY: clean-dmon # rmd, remove dmon binary

rmd: clean-dmon

clean-dmon-image:
	$(call _echo,deleting dmon docker image)
	# -$(MAKE) -C $(dmon) delimage
.PHONY: clean-dmon # rmid, delete dmon docker image

rmid: clean-dmon-image

clean-wgen:
	$(call _echo,removing wgen binary)
	# $(MAKE) -C $(wgen) clean
.PHONY: clean-wgen # rmw, remove wgen binary

rmw: clean-wgen

clean-flow:
	$(call _echo,removing flow binary)
	# $(MAKE) -C $(flow) clean
.PHONY: clean-flow # rmf, remove flow binary

rmf: clean-flow

# ----- DOCKER -----

clean-docker:
	$(call _echo,cleaning docker env)
	-docker system prune -f --volumes
.PHONY: clean-docker # rmdk, clean docker env

rmdk: clean-docker

# ----- APPLICATIONS -----

start-robotshop:
	$(MAKE) -C $(robotshop) start
.PHONY: start-robotshop # rs, start robotshop + dmon docker image

rs: start-robotshop 

stop-robotshop:
	$(MAKE) -C $(robotshop) stop
.PHONY: stop-robotshop # rsp, stop robotshop + dmon docker image

rsp: stop-robotshop 


start-sockshop:
	$(MAKE) -C $(sockshop) start
.PHONY: start-sockshop # ss, start sockshop + dmon docker image

ss: start-sockshop 

stop-sockshop:
	$(MAKE) -C $(sockshop) stop
.PHONY: stop-sockshop # ssp, stop sockshop + dmon docker image

ssp: stop-sockshop 


start-lakeside:
	$(MAKE) -C $(lakeside) start
.PHONY: start-lakeside # ls, start lakeside + dmon docker image

ls: start-lakeside 

stop-lakeside:
	$(MAKE) -C $(lakeside) stop
.PHONY: stop-lakeside # lsp, stop lakeside + dmon docker image

lsp: stop-lakeside 
