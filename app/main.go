package main

import (
	"github.com/gin-gonic/gin"
	"iqj/api/handlers"
	"iqj/api/middleware"
	"iqj/api/scraper"
	"iqj/config"
	"iqj/database"
	"log"
)

func main() {
	// БД
	database.ConnectStorage()

	// Запускает парсер новостей
	go scraper.ScrapTick()

	// Создание роутера.
	r := gin.Default()

	// Добавляет заголовки CORS к ответам сервера.
	// Необходимо для того, чтобы клиентские приложения,
	// работающие на других доменах, могли взаимодействовать с API.
	r.Use(middleware.CORSMiddleware())

	// Вызов хэндлеров исходя из запроса.

	r.POST("/sign-up", handlers.HandleSignUp)
	r.POST("/sign-in", handlers.HandleSignIn)

	r.GET("/news", handlers.HandleGetNews)
	r.GET("/news_id", handlers.HandleGetNewsById)

	r.GET("/ad", handlers.HandleGetAd)

	r.GET("/lessons", handlers.Lessons)

	// Группа функций, которая доступна только после аутентификации
	authGroup := r.Group("/api")
	authGroup.Use(middleware.WithJWTAuth)
	{
		authGroup.POST("/news", handlers.HandleAddNews)
		authGroup.POST("/ad", handlers.HandlePostAd)

		//Для тестов
		authGroup.POST("/ad2", handlers.HandlePostAd2)
	}

	// Запускает сервер на порту и "слушает" запросы.
	if err := r.RunTLS(":8443", config.SertificatePath, config.KeyPath); err != nil {
		log.Fatal(err)
	}
}
