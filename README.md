# :tada: Digital Ocean S3/Object Storage Mysql Backup ( kubernets cronjob, local script, local docker container )

![GitHub Release Date:](https://img.shields.io/github/release-date-pre/ricristian/digitalocean-s3-k8s-mysql-cronjob)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/ricristian/digitalocean-s3-k8s-mysql-cronjob)
![Github issues](https://img.shields.io/github/issues/ricristian/digitalocean-s3-k8s-mysql-cronjob)
![GitHub open pull requests](https://img.shields.io/github/issues-pr-raw/ricristian/digitalocean-s3-k8s-mysql-cronjob)
![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed-raw/ricristian/digitalocean-s3-k8s-mysql-cronjob)

Backup mysql into s3/space from DigitalOcean

## How to 

### Deploy on k8s
Update `namespace: mysql` with your namespace

```shell
kubectl apply -f cronjob.yml
```

### Run locally using docker
```sh
docker run --name mysql-backup-s3 --env-file ./env ghcr.io/ricristian/digitalocean-s3-k8s-mysql-cronjob:v1.0
```
## TO DO: 
- [ ] Replace static data retention ( 7 days ) to a dynamic variable
- [ ] Improve documentation
- [x] Add environment variables to cronjob.yml (k8s)
- [ ] Add more running examples for different os & distributions ( mac os, linux)
- [x] Test into a live k8s cluster & mysql stateful set 