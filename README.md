# GitLab 유지보수용 프로젝트

GitLab 설치/업데이트등의 운영에 필요한 스크립트 및 설정을 관리합니다.

## Prerequisite
- docker & docker-compose

## Setup
- `make install`
- `make up` 또는 `IMAGE_TAG={버전 태그} make up`

## Update
- `make down`
- `make update`
- `make up`

## Persistent Volumes
Persistent하게 유지되어야 하는 파일들은 아래 경로에 마운트되어 있습니다. 이 데이터들은 주기적으로 백업되어야 합니다.

- volumes/app: git저장소 데이터 및 대부분의 데이터 파일들이 보관됩니다.
- volumes/config: gitlab의 환경설정 파일 및 secret값들이 보관됩니다.
- volumes/logs: 로그파일 저장
- volumes/secret: 백업수행시 위의 config 백업파일이 저장되는 곳입니다. 이 디렉터리의 내용을 별도로 안전한곳에 보관해야 합니다.
