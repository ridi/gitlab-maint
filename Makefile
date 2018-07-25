.PHONY: install up down logs update backup

install:
	mkdir -p -m 750 ./volumes/app ./volumes/config ./volumes/logs

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
	gitlab-rake gitlab:backup:create
	sudo docker restart gitlab
