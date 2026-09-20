# fibo-planner-on-gcp
repo to manage fibo-planner on google cloud platform

## Cloud run

- https://fibo-planner-189393002108.asia-southeast1.run.app/

## Release Steps

### build docker image

- update `./docker/*`
- update `./justfile` - `docker_image` version
- `$ just docker-build`
- optionally, test with `$ just docker-run`

### publish docker image

- `$ just docker-login`
- `$ just docker-push`

### update cloud run
- `$ just gcp-login`
- `$ just set-project`
- `$ just set-region`
- `$ just cloud-run`
- optionally, `$ just describe-run`
