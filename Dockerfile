FROM golang:latest

#ENV PORT=443

WORKDIR /iqj

COPY . .

# init db
COPY /docker_scripts/init.sql /docker-entrypoint-initdb.d/init.sql


RUN go mod download
RUN go build /iqj/app/main.go

#EXPOSE $PORT

CMD ["./main"]
