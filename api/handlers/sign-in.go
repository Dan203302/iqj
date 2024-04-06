package handlers

import (
	"github.com/gin-gonic/gin"
	"iqj/api/middleware"
	"iqj/database"
	"iqj/models"
	"net/http"
)

// Вход в систему
// Получаем данные, введенные пользователем из тела запроса и записываем их
// Возвращаем JWT
func HandleSignIn(c *gin.Context) {

	// Получаем данные, введенные пользователем из тела запроса и записываем их в signingUser
	var signingUser models.User
	err := c.BindJSON(&signingUser.Data)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
	}

	// Проверяем существует ли такой пользователь и проверяем верный ли пароль
	userId, err := database.Database.CheckUser(&signingUser)
	if err != nil {
		c.String(http.StatusUnauthorized, "") // Если пользователя нет или пароль неверный вернем пустую строку и ошибку
		return
	}

	// Если все хорошо сделаем JWT токен

	// Получаем токен для пользователя
	token, err := middleware.GenerateJWT(userId)
	if err != nil {
		c.String(http.StatusInternalServerError, "")
		return
	}

	//Выводим токен в формате JSON
	c.JSON(http.StatusOK, token)
}
