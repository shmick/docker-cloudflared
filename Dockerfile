FROM alpine:3.14 AS builder

ENV VERSION "2021.9.1"

ARG TARGETARCH

ENV FILE
RUN if [ "$TARGETARCH" = "arm" ] ; then FILE=cloudflared-linux-arm ; fi
RUN if [ "$TARGETARCH" = "amd64" ] ; then FILE=cloudflared-linux-amd64 ; fi

ENV URL "https://github.com/cloudflare/cloudflared/releases/download/${VERSION}/${FILE}"

RUN apk update \
  && apk add curl \
  && curl -L $URL -o cloudflared

FROM alpine:3.14

WORKDIR /usr/local/bin

COPY --from=builder cloudflared . 
RUN chmod +x cloudflared

ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
