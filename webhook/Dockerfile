FROM golang:1.11-stretch

RUN mkdir /echo
WORKDIR /echo
ADD https://raw.githubusercontent.com/prometheus/alertmanager/v0.16.1/examples/webhook/echo.go /echo/echo.go
RUN go build
EXPOSE 5001
ENTRYPOINT ["/echo/echo"]
