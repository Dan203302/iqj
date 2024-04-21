package handlers

import (
	"iqj/api/middleware"
	"iqj/database"
	"iqj/models"
	"net/http"

	"github.com/gin-gonic/gin"
)

// Вход в систему
// Получаем данные, введенные пользователем из тела запроса и записываем их
// Возвращаем JWT
func HandleSignIn(c *gin.Context) {

	// Получаем данные, введенные пользователем из тела запроса и записываем их в signingUser
	var signingUser models.User
	err := c.BindJSON(&signingUser)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
	}

	if signingUser.Data.Email == "" {
		c.JSON(http.StatusBadRequest, "There is no email")
	}

	if signingUser.Data.Password == "" {
		c.JSON(http.StatusBadRequest, "There is no password")
	}

	// Проверяем существует ли такой пользователь и проверяем верный ли пароль

	user, err := database.Database.CheckUser(&signingUser)
	if err != nil {
		c.String(http.StatusUnauthorized, "") // Если пользователя нет или пароль неверный вернем пустую строку и ошибку
		return
	}

	// Если все хорошо сделаем JWT токен

	// Получаем токен для пользователя
	token, err := middleware.GenerateJWT(user.Id)
	if err != nil {
		c.String(http.StatusInternalServerError, "")
		return
	}

	//Выводим токен в формате JSON
	c.JSON(http.StatusOK, token)
}
