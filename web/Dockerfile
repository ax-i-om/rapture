FROM golang:1.22-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY . ./

RUN go build -o rapture-web .

CMD [ "/app/rapture-web"]

EXPOSE 6175