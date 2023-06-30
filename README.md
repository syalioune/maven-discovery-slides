# Maven discovery slides

## Prerequisites

* [go](https://go.dev/doc/install)
* [gohugo](https://gohugo.io/)

## Run locally

```shell
go get -d github.com/dzello/reveal-hugo@upgrade
hugo server
```

The slides are available at http://localhost:1313

## Docker run

```shell
docker build . -t maven-discovery-slides
docker run -d -p 1313:1313
```

The slides are available at http://localhost:1313

## Build and push image for CI

```shell
docker build . -f Dockerfile.pages -t syalioune/hugo-with-go:0.0.1
docker login -u syalioune
docker push syalioune/hugo-with-go:0.0.1
```