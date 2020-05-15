FROM golang:alpine AS build-env
ADD . /work
WORKDIR /work

ENV GAURUN_VERSION 0.13.0
ENV GAURUN_SHA1 d2d6c25749bf47a86b0d204260b57267a535f04d

RUN apk add --no-cache --virtual .build-deps \
  wget \
  tar \
  make \
  && wget -O gaurun.tar.gz "https://github.com/mercari/gaurun/archive/v${GAURUN_VERSION}.tar.gz" \
  && echo "$GAURUN_SHA1  gaurun.tar.gz" | sha1sum -c - \
  && mkdir src \
  && tar -xzf gaurun.tar.gz -C src --strip-components=1 \
  && cd src \
  && make


FROM alpine

RUN mkdir /gaurun
WORKDIR /gaurun

ADD ./conf /gaurun/conf
COPY entrypoint.sh /usr/bin/
COPY --from=build-env /work/src/bin/gaurun /usr/local/bin/gaurun
RUN chmod +x /usr/bin/entrypoint.sh /usr/local/bin/gaurun

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 1056

CMD ["gaurun", "-c", "conf/gaurun.toml"]
