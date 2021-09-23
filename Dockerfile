FROM alpine:3.14 AS builder

ENV VERSION "2021.9.1"

ARG TARGETARCH

RUN if [ "$TARGETARCH" = "arm" ] ; then export FILE=cloudflared-linux-arm ; fi
RUN if [ "$TARGETARCH" = "amd64" ] ; then export FILE=cloudflared-linux-amd64 ; fi

ARG FILE

ENV BASEURL "https://github.com/cloudflare/cloudflared/releases/download/${VERSION}"

RUN apk update \
  && apk add curl \
  && if [ "$TARGETARCH" = "arm" ] ; then export FILE=cloudflared-linux-arm ; fi \
  && if [ "$TARGETARCH" = "amd64" ] ; then export FILE=cloudflared-linux-amd64 ; fi
  && curl -L ${BASEURL}/${FILE} -o cloudflared

FROM alpine:3.14

WORKDIR /usr/local/bin

COPY --from=builder cloudflared . 
RUN chmod +x cloudflared

ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
