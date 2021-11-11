FROM golang:1.9 AS gobuild

WORKDIR /go/src/github.com/paw-digital/nano
RUN go get \
  github.com/paw-digital/crypto/ed25519 \
  golang.org/x/crypto/blake2b \
  github.com/pkg/errors \
  github.com/dgraph-io/badger

COPY . ./

RUN go build -o nano .


FROM debian:8-slim

COPY --from=gobuild /go/src/github.com/paw-digital/nano/nano /nano

ENTRYPOINT ["/nano"]
