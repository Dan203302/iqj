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
	r.GET("/news", handlers.HandleGetNews)
	r.GET("/news_id", handlers.HandleGetNewsById)

	r.GET("/ad", handlers.HandleGetAd)

	r.POST("/sign-up", handlers.HandleSignUp)
	r.POST("/sign-in", handlers.HandleSignIn)

	// Группа функций, которая доступна только после аутентификации
	authGroup := r.Group("/api")
	authGroup.Use(middleware.WithJWTAuth())
	{
		r.POST("/add_news", handlers.HandleAddNews)
		r.POST("/ad", handlers.HandlePostAd)
	}

	// Запускает сервер на порту и "слушает" запросы.
	if err := r.RunTLS(":443", config.SertificatePath, config.KeyPath); err != nil {
		log.Fatal(err)
	}

}
