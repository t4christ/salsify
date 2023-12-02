FROM golang:1.19-alpine as builder

WORKDIR /salsify/goapp/demo

COPY go.mod go.sum .

RUN go mod download

COPY . .

RUN go build -o salsify-news


FROM golang:1.19-alpine

ARG UID=65534
ARG GID=65534

WORKDIR /salsify/goapp/demo

COPY --from=builder /salsify/goapp/demo/salsify-news /salsify/goapp/demo
COPY --from=builder /salsify/goapp/demo/assets /salsify/goapp/demo/assets
COPY --from=builder /salsify/goapp/demo/index.html /salsify/goapp/demo


USER ${UID}:${GID}

EXPOSE 4000

CMD ["./salsify-news"]