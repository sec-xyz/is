# IMAGE: docker.io/golang:1-bullseye  - jun2, 2022
FROM docker.io/golang:bullseye@sha256:db42e4bb1a7f32da1ec430906769dbbabe9f1868bd4170751e4923f1b8948a45

COPY ./ /src
WORKDIR /src
RUN go install github.com/form3tech/innsecure/cmd/innsecure

EXPOSE 8080

ENTRYPOINT ["innsecure"]
