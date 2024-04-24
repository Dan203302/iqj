package handler

import (
	"iqj/api/middleware"
	"iqj/database"
	"net/http"

	"github.com/gin-gonic/gin"
)

// Вход в систему
// Получаем данные, введенные пользователем из тела запроса и записываем их
// Возвращаем JWT
func (h *Handler) HandleSignIn(c *gin.Context) {

	// Получаем данные, введенные пользователем из тела запроса и записываем их в signingUser
	var signingUser database.User
	err := c.BindJSON(&signingUser)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
	}

	if signingUser.Email == "" {
		c.JSON(http.StatusBadRequest, "There is no email")
	}

	if signingUser.Password == "" {
		c.JSON(http.StatusBadRequest, "There is no password")
	}

	// Проверяем существует ли такой пользователь и проверяем верный ли пароль
	user, err := database.Database.User.Check(&signingUser)
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
