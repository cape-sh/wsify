FROM golang:alpine AS build-env
RUN apk update && apk add git
WORKDIR /root/
RUN go get github.com/alash3al/wsify
RUN chmod +x /go/bin/wsify


FROM alpine:3.11
COPY --from=build-env /go/bin/wsify /wsify
ENV USER_UID=1001 USER_NAME=cape-api
RUN adduser ${USER_NAME} --uid=1001 --disabled-password
USER ${USER_UID}
ENTRYPOINT ["/wsify"]