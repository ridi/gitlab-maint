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

backup-app:
	docker exec -t gitlab gitlab-rake gitlab:backup:create

backup-config:
	docker exec -t gitlab /bin/sh -c 'umask 0077; tar cfz /secret/$$(date "+etc-gitlab-%s.tgz") -C / etc/gitlab'

latest-config:= $(shell ls -t volumes/secret | head -1)
upload-config:
	AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) AWS_DEFAULT_REGION=ap-northeast-2 \
		./aws.sh s3 cp ./volumes/secret/$(latest-config) s3://ridi-perf-gitlab-backup

backup: backup-app backup-conifg upload-config
