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