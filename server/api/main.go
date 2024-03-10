package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"iqj/database"
	"iqj/server/scraper"
	"log"
	"net/http"
	"strconv"
)

func GetNews(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello, niggas 2!"))
}

func GetNewsById(w http.ResponseWriter, r *http.Request) {
	idstr := mux.Vars(r)["id"]
	id, err := strconv.Atoi(idstr)
	if err != nil {
		fmt.Println(err)
	}
	news, err := database.Database.GetNewsByID(id)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(news)
}

func main() {

	database.ConnectStorage()

	go scraper.ScrapTick()

	router := mux.NewRouter()
	router.HandleFunc("/news", GetNews)
	router.HandleFunc("/news/{id}", GetNewsById)
	if err := http.ListenAndServe(":8080", router); err != nil {
		log.Fatal(err)
	}
}
