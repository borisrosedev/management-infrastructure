CYAN_COLOR=\033[1;36m
NO_COLOR=\033[0m

.DEFAULT_GOAL := help 
.PHONY: help ansible 

help: ## shows this help
	@grep -E "^[a-zA-Z_-]+: ## .*$$" $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ": ## "}; {printf "${CYAN_COLOR}%-15s${NO_COLOR}%s\n", $$1, $$2}'

ansible: ## runs ansible playbook
	ansible-playbook -i ./ansible/hosts_local.ini ./ansible/playbook.yml