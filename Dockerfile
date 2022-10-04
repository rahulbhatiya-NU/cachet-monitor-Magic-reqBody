FROM golang:1.19
WORKDIR /build

COPY . .

RUN go mod tidy
RUN cd cli && CGO_ENABLED=0 go build -ldflags "-s" -o app .

FROM alpine:3.14.2
WORKDIR /app

RUN apk --no-cache add ca-certificates

COPY --from=0 /build/app ./

CMD ["./app"]