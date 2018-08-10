.PHONY: install up down logs update backup

install:
	mkdir -p -m 750 ./volumes/app ./volumes/config ./volumes/logs ./volumes/secret

up: IMAGE_TAG ?= latest
up:
	IMAGE_TAG=$(IMAGE_TAG) \
	docker-compose up -d

down:
	docker-compose down

logs:
	docker-compose logs --follow

update:
	docker pull gitlab/gitlab-ce:latest

backup:
	# Backup Application
	docker exec -t gitlab gitlab-rake gitlab:backup:create
	# Backup Configuration
	docker exec -t gitlab /bin/sh -c 'umask 0077; tar cfz /secret/$$(date "+etc-gitlab-%s.tgz") -C / etc/gitlab'
