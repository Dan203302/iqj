package handler

import (
	"github.com/gin-gonic/gin"
	"iqj/api/middleware"
	"iqj/service"
	"net/http"
)

type Handler struct {
	services *service.Service
}

func NewHandler(services *service.Service) *Handler {
	return &Handler{services: services}
}

func (h *Handler) InitRoutes() *gin.Engine {
	// Вызов хэндлеров исходя из запроса.
	r := gin.Default()

	r.GET("/", h.Hello)
	r.POST("/sign-up", h.HandleSignUp)
	r.POST("/sign-in", h.HandleSignIn)

	r.GET("/news", h.HandleGetNews)
	r.GET("/news_id", h.HandleGetNewsById)

	r.GET("/ad", h.HandleGetAd)

	//r.GET("/lessons", h.Lessons)

	// Группа функций, которая доступна только после аутентификации
	authGroup := r.Group("/api")
	authGroup.Use(middleware.WithJWTAuth)
	{
		authGroup.POST("/news", h.HandleAddNews)
		authGroup.POST("/ad", h.HandlePostAd)
	}
	return r
}

func (h *Handler) Hello(c *gin.Context) {
	c.String(http.StatusOK, "Добро пожаловать в IQJ")
}
