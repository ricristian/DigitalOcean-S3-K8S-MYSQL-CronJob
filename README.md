# digitalocean-s3-k8s-mysql-cronjob

![GitHub Release Date:](https://img.shields.io/github/release-date-pre/ricristian/digitalocean-s3-k8s-mysql-cronjob)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/ricristian/digitalocean-s3-k8s-mysql-cronjob)
![Github issues](https://img.shields.io/github/issues/ricristian/digitalocean-s3-k8s-mysql-cronjob)
![GitHub open pull requests](https://img.shields.io/github/issues-pr-raw/ricristian/digitalocean-s3-k8s-mysql-cronjob)
![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed-raw/ricristian/digitalocean-s3-k8s-mysql-cronjob)

Backup mysql into s3/space from DigitalOcean

## How to 

### Deploy on k8s:
* Update `namespace: mysql` with your namespace
* `kubectl apply -f cronjob.yml`

### Run locally using docker: 
* `docker run --name mysql-backup-s3 --env-file ./env ghcr.io/ricristian/digitalocean-s3-k8s-mysql-cronjob:v1.0`

## TO DO: 
- [ ] Improve documentation
- [ ] Add environment variables to cronjob.yml (k8s)
