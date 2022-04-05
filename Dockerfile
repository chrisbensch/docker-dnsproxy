FROM golang:1.18 as builder

RUN git clone https://github.com/adguardteam/dnsproxy
WORKDIR dnsproxy
RUN go build

FROM debian:bullseye-slim

ENV DNSPROXY_UPSTREAM="https://dns.emeraldonion.org"
ENV DNSPROXY_BOOTSTRAP="1.1.1.1"

COPY --from=builder /go/dnsproxy/dnsproxy .

CMD ./dnsproxy --cache-size=0 --bootstrap $DNSPROXY_BOOTSTRAP --upstream $DNSPROXY_UPSTREAM
EXPOSE 53
