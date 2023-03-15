FROM debian:bullseye-slim AS build

WORKDIR /gcsproxy

COPY go.mod go.sum main.go ./

RUN apt-get update && \
    apt-get install -y ca-certificates golang && \
    go build

FROM gcr.io/distroless/base
COPY --from=build /gcsproxy/gcsproxy /gcsproxy
CMD ["/gcsproxy"]
