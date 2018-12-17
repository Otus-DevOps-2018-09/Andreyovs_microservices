FROM alpine:3.4

WORKDIR /app
COPY Gemfile* /app/

RUN \
    apk update \
    && apk upgrade \
    && apk add --no-cache --virtual build-dependencies ruby-dev build-base \
    && apk add --no-cache ruby ruby-bundler \
    && bundle config --global silence_root_warning 1 \
    && bundle install \
    && apk del build-dependencies

COPY . /app

ENV POST_SERVICE_HOST post
ENV COMMENT_SERVICE_PORT 9292
ENV COMMENT_SERVICE_HOST comment
ENV POST_SERVICE_PORT 5000

CMD ["puma"]
