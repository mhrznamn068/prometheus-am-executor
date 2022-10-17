FROM golang:1.16-alpine as builder
WORKDIR /app
RUN apk add build-base
COPY . .
RUN go test -count 1 -v ./... 
RUN go build

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /app/prometheus-am-executor ./
RUN cp ./prometheus-am-executor /usr/local/bin

