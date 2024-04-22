package main

import (
	"iqj/api/handler"
	"iqj/api/middleware"
	"iqj/api/scraper"
	"iqj/config"
	"iqj/database"
	"iqj/service"
	"log"
)

func main() {
	services := service.NewService()
	handlers := handler.NewHandler(services)

	// БД
	database.NewDatabaseInstance()

	// Запускает парсер новостей
	go scraper.ScrapTick()

	// Добавляет заголовки CORS к ответам сервера.
	// Необходимо для того, чтобы клиентские приложения,
	// работающие на других доменах, могли взаимодействовать с API.
	handlers.InitRoutes().Use(middleware.CORSMiddleware())

	// Запускает сервер на порту и "слушает" запросы.
	if err := handlers.InitRoutes().RunTLS(":8443", config.SertificatePath, config.KeyPath); err != nil {
		log.Fatal(err)
	}
}
