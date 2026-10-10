# Same toolchain as CI: Hugo and Dart Sass come from npm (see package.json),
# Go is needed to download the Docsy Hugo module.
FROM node:lts

COPY --from=golang:1 /usr/local/go /usr/local/go
ENV PATH="/usr/local/go/bin:${PATH}"

RUN git config --global --add safe.directory /src

WORKDIR /src
