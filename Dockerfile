# IMAGE: docker.io/golang:1-bullseye  - jun2, 2022
FROM docker.io/golang:bullseye@sha256:5417b4917fa7ed3ad2678a3ce6378a00c95bfd430c2ffa39936fce55130b5f2c

COPY ./ /src
WORKDIR /src
RUN go install github.com/form3tech/innsecure/cmd/innsecure

EXPOSE 8080

ENTRYPOINT ["innsecure"]
