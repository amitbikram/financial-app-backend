FROM golang:1.14.4 as builder
ENV DATA_DIRECTORY /Users/sarangi/playground/financial-app/financial-app-backend
WORKDIR ${DATA_DIRECTORY}
ARG APP_VERSION
ARG CGO_ENABLED=0
COPY . .
RUN go build -ldflags="-X github.com/amitbikram/financial-app-backend/internal/config.Version=$APP_VERSION" github.com/amitbikram/financial-app-backend/cmd/server

FROM alpine:3.10
ENV DATA_DIRECTORY /Users/sarangi/playground/financial-app/financial-app-backend
RUN apk add --update --no-cache ca-certificates
COPY --from=builder ${DATA_DIRECTORY}/server /financial-app-backend
ENTRYPOINT [ "/financial-app-backend" ]
