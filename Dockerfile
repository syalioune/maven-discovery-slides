FROM klakegg/hugo:0.111.3-ubuntu

COPY . /src

RUN apt-get update -y && \
    apt-get install -y golang-go git && \
    cd /src && \
    go get -d github.com/dzello/reveal-hugo@upgrade

EXPOSE 1313

CMD ["server"]