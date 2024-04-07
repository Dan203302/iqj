FROM golang:latest

ENV PORT=22

WORKDIR /iqj

COPY . .

# init db

RUN go mod download
RUN go build /iqj/app/main.go

EXPOSE $PORT

CMD ["./iqj/app/main"]
