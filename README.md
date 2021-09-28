# digitalocean-s3-k8s-mysql-cronjob
Backup mysql into s3/space from DigitalOcean

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/ricristian/digitalocean-s3-k8s-mysql-cronjob)][github-release]
![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed-raw/ricristian/digitalocean-s3-k8s-mysql-cronjobr)][github-stargazers]
![Github release workflow](https://img.shields.io/github/workflow/status/netbox-community/netbox-docker/release)
![Docker Pulls](https://img.shields.io/docker/pulls/ricristian/digitalocean-s3-k8s-mysql-cronjob)
[![GitHub license](https://img.shields.io/github/license/ricristian/digitalocean-s3-k8s-mysql-cronjob)][netbox-docker-license]

## How to 

Deploy on k8s:
* Update `namespace: mysql` with your namespace
* `kubectl apply -f cronjob.yml`

Run locally: 
* `docker run --name mysql-backup-s3 --env-file ./env ghcr.io/ricristian/digitalocean-s3-k8s-mysql-cronjob:v1.0`

## TO DO: 
- [ ] Improve documentation
- [ ] Add environment variables to cronjob.yml (k8s)
