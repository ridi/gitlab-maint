.PHONY: install up down logs update backup

install:
	mkdir -p -m 750 ./volumes/app ./volumes/config ./volumes/logs

up:
	docker-compose up -d

down:
	docker-compose down

logs:
	docker-compose logs --follow

update:
	docker pull gitlab/gitlab-ce:latest

backup:
	docker exec gitlab gitlab-rake gitlab:backup:create
	docker restart gitlab
