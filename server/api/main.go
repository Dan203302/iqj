package main

import (
	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
	"log"
	"net/http"
	"projects/elitka/project_root/server/scraper"
)

func Write(w http.ResponseWriter, r *http.Request) {
	if _, err := w.Write([]byte("Hello, world!")); err != nil {
		log.Fatal(err)
	}
}

func main() {
	scraper.Scraper()
	router := mux.NewRouter()
	router.HandleFunc("/", Write)
	if err := http.ListenAndServe(":8080", router); err != nil {
		log.Fatal(err)
	}
}
