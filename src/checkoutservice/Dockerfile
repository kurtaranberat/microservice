
FROM golang:1.23.1-alpine@sha256:ac67716dd016429be8d4c2c53a248d7bcdf06d34127d3dc451bda6aa5a87bc06 AS builder
WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .
ARG SKAFFOLD_GO_GCFLAGS
RUN CGO_ENABLED=0 GOOS=linux go build -gcflags="${SKAFFOLD_GO_GCFLAGS}" -o /checkoutservice .

FROM scratch

WORKDIR /src
COPY --from=builder /checkoutservice /src/checkoutservice

ENV GOTRACEBACK=single

EXPOSE 5050
ENTRYPOINT ["/src/checkoutservice"]
