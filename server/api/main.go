package main

import (
	"github.com/gorilla/mux"
	"iqj/server/scraper"
	"log"
	"net/http"
)

func main() {

	// database.ConnectStorage()

	go scraper.ScrapTick()
	router := mux.NewRouter()
	if err := http.ListenAndServe(":8080", router); err != nil {
		log.Fatal(err)
	}
}
