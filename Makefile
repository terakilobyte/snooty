GIT_BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
USER=$(shell whoami)
STAGING_URL="https://docs-mongodborg-staging.corp.mongodb.com"
STAGING_BUCKET=docs-mongodb-org-staging
include .env.production

.PHONY: stage static

stage:
	@if [ -z "${GATSBY_SNOOTY_DEV}" ]; then \
		echo "To stage changes to the Snooty frontend, ensure that GATSBY_SNOOTY_DEV=true in your production environment."; exit 1; \
	else \
		mut-publish public ${STAGING_BUCKET} --prefix=${GATSBY_SITE} --stage ${ARGS}; \
		echo "Hosted at ${STAGING_URL}/${GATSBY_SITE}/${USER}/${GIT_BRANCH}/"; \
	fi

static:
	-rm -r ./static/images/
	-rm -r ./static/docs-tools/
	-rm -r ./docs-tools/
	git submodule add --force https://github.com/mongodb/docs-tools
	-mkdir -p ./static/images
	mv ./docs-tools/themes/mongodb/static ./static/docs-tools/
	mv ./docs-tools/themes/guides/static/images/bg-accent.svg ./static/docs-tools/images/bg-accent.svg