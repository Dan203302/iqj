FROM golang:latest

#ENV PORT=443

WORKDIR /iqj

COPY . .

# init db
COPY /docker_scripts/create-db.sql /docker-entrypoint-initdb.d/create-db.sql


RUN go mod download
RUN go build /iqj/app/main.go

#EXPOSE $PORT

CMD ["./main"]
