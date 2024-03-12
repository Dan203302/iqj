package main

import (
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	"iqj/database"
	"iqj/server/scraper"
	"log"
	"net/http"
	"strconv"
)

func handleGetNews(w http.ResponseWriter, r *http.Request) {
	// Получаем промежуток пропуска и количество блоков новостей
	offsetStr := r.URL.Query().Get("offset")
	countStr := r.URL.Query().Get("count")

	offset, err := strconv.Atoi(offsetStr)
	if err != nil {
		http.Error(w, "Invalid offset parameter", http.StatusBadRequest)
		return
	}
	count, err := strconv.Atoi(countStr)
	if err != nil {
		http.Error(w, "Invalid count parameter", http.StatusBadRequest)
		return
	}

	latestnews, err := database.Database.GetLatestNewsBlocks(offset, count)
	if err != nil {
		fmt.Println(err)
	}
	WriteJSON(w, http.StatusOK, latestnews)
}

func handleGetNewsById(w http.ResponseWriter, r *http.Request) {
	idstr := mux.Vars(r)["id"]
	id, err := strconv.Atoi(idstr)
	if err != nil {
		fmt.Println(err)
	}
	news, err := database.Database.GetNewsByID(id)
	if err != nil {
		fmt.Println(err)
	}
	WriteJSON(w, http.StatusOK, news)
}

func main() {

	database.ConnectStorage()

	go scraper.ScrapTick()

	router := mux.NewRouter()
	router.HandleFunc("/news", handleGetNews)
	router.HandleFunc("/news/{id}", handleGetNewsById)
	if err := http.ListenAndServe(":8080", router); err != nil {
		log.Fatal(err)
	}
}

func WriteJSON(w http.ResponseWriter, status int, v any) error {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(status)
	return json.NewEncoder(w).Encode(v)
}
