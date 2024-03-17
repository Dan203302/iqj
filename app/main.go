package main

import (
	"github.com/gorilla/mux"
	"iqj/api/handlers"
	"iqj/api/middleware"
	"iqj/api/scraper"
	"iqj/database"
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
	router.HandleFunc("/sign-in", middleware.SignIn)
	// Запускает сервер на порту и "слушает" запросы.
	if err := http.ListenAndServe(":8080", router); err != nil {
		log.Fatal(err)
	}
}
