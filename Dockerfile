FROM alpine:3.14 AS builder

ENV VERSION "2021.9.2"

ARG TARGETARCH

ENV URL "https://github.com/cloudflare/cloudflared/releases/download/${VERSION}/cloudflared-linux-${TARGETARCH}"

RUN apk update \
  && apk add curl \
  && curl -L ${URL} -o cloudflared
  
FROM alpine:3.14

WORKDIR /usr/local/bin

COPY --from=builder cloudflared . 
RUN chmod +x cloudflared

ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
