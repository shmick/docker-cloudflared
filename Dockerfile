FROM public.ecr.aws/docker/library/alpine:3.21 AS builder

ARG VERSION="2025.8.1"

ARG TARGETARCH

ARG URL="https://github.com/cloudflare/cloudflared/releases/download/${VERSION}/cloudflared-linux-${TARGETARCH}"

RUN apk update && apk add curl && curl -L ${URL} -o cloudflared
  
FROM public.ecr.aws/docker/library/alpine:3.21

WORKDIR /usr/local/bin

COPY --from=builder cloudflared . 
RUN chmod +x cloudflared

ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
