FROM golang:latest

ENV PORT=22

WORKDIR /server

COPY . .

RUN go mod download
RUN go build server/api/main.go

EXPOSE $PORT

CMD ["./server/api/main"]