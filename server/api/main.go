package main

import (
	_ "github.com/lib/pq"
	"projects/elitka/project_root/server/scraper"
)

func main() {
	scraper.Scraper()
	//router := mux.NewRouter()
	//if err := http.ListenAndServe(":8080", router); err != nil {
	//	log.Fatal(err)
	//}
}
