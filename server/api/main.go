package main

import (
	"github.com/gorilla/mux"
	"iqj/database"
	"iqj/handlers"
	"iqj/server/scraper"
	"log"
	"net/http"
)

func main() {
	// БД
	database.ConnectStorage()

	// Запускает парсер новостей
	go scraper.ScrapTick()

	// Создание роутера.
	router := mux.NewRouter()
	// Вызов хэндлеров исходя из запроса.
	router.HandleFunc("/news", handlers.HandleGetNews)
	router.HandleFunc("/news/{id}", handlers.HandleGetNewsById)
	// Запускает сервер на порту и "слушает" запросы.
	if err := http.ListenAndServe(":8080", router); err != nil {
		log.Fatal(err)
	}
}
