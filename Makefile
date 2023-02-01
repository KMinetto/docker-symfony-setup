# Variables
DOCKER = docker
DOCKER_COMPOSE = docker-compose
EXEC = ${DOCKER} exec -w /var/www/project www_project
PHP = ${EXEC} php
NPM = ${EXEC} npm
SYMFONY_CONSOLE = ${PHP} bin/console
.DEFAULT_GOAL:= help
.PHONY: help

# Colors
GREEN = /bin/echo -e "\x1b[32m\#\# $1\x1b[0m"
RED = /bin/echo -e "\x1b[31m\#\# $1\x1b[0m"

## -- APP --
init: ## Initialize the project
	${MAKE} docker-start
	${MAKE} composer-install
	@$(call GREEN,"The application is available at: http://127.0.0.1:8000/.")

stop: ## Stop the application
	${MAKE} docker-stop

## -- Docker --
docker-start: ## Start app
	${DOCKER_COMPOSE} up -d
docker-stop:
	${DOCKER_COMPOSE} stop

cache-clear: ## Clear the Cache
	${SYMFONY_CONSOLE} cache:clear

## -- Composer --
composer-install: ## Install composer dependencies
	${COMPOSER} install
composer-update: ## Update composer dependencies
	${COMPOSER} update

## -- Database --
database-init: ## init the database
	${MAKE} database-drop
	${MAKE} database-create
	${MAKE} schemas
	${MAKE} fixtures
	@$(call GREEN,"The database has been successfully created and fixtures has been loaded.")

database-drop: ## drop the database
	${SYMFONY_CONSOLE} d:d:d --force --if-exists
database-create: ## Create the database
	${SYMFONY_CONSOLE} d:d:c --if-not-exists
database-schema-update: ## Update Schemas
	${SYMFONY_CONSOLE} d:s:u --force
schemas: ## Alias: database-schema-update
	${MAKE} database-schema-update
database-fixtures: ## Load fixtures in database
	${SYMFONY_CONSOLE} d:f:l --no-interaction
fixtures: ## Alias: database-fixtures
	${MAKE} database-fixtures

help: ## Lists all commands available
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sed -n 's/^\(.*\): \(.*\)##\(.*\)/\1\3/p' \
	| column -t  -s ' '