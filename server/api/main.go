package main

import (
	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
	"log"
	"net/http"
	"projects/elitka/project_root/server/scraper"
)

func main() {
	scraper.ScrapTick()
	router := mux.NewRouter()
	if err := http.ListenAndServe(":8080", router); err != nil {
		log.Fatal(err)
	}
}
