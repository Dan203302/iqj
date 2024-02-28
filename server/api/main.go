package github

import (
	"github.com/gorilla/mux"
	"github.com/mirea/iqj/server/scraper"
	"log"
	"net/http"
)

func main() {
	go scraper.ScrapTick()
	router := mux.NewRouter()
	if err := http.ListenAndServe(":8080", router); err != nil {
		log.Fatal(err)
	}
}
