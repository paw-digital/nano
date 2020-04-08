FROM golang:1.9 AS gobuild

WORKDIR /go/src/github.com/bbedward/nano
RUN go get \
  github.com/bbedward/crypto/ed25519 \
  golang.org/x/crypto/blake2b \
  github.com/pkg/errors \
  github.com/dgraph-io/badger

COPY . ./

RUN go build -o nano .


FROM debian:8-slim

COPY --from=gobuild /go/src/github.com/bbedward/nano/nano /nano

ENTRYPOINT ["/nano"]
