package handlers

import (
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
	"iqj/database"
	"iqj/models"
	"net/http"
)

func HandleSignUp(c *gin.Context) {
	var user models.UserData

	err := c.BindJSON(&user)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
	}
	password := user.Password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		c.String(http.StatusInternalServerError, err.Error())
	}
	user.Password = string(hashedPassword)

	database.Database.AddUser(user) // и тип тут поменяйте, функция рабочая просто впихните нужные данные
	// TODO: передайте фронтенду чтобы у них регистрация была полноценная, чтобы он только после получения всех данных отправлял сюда запрос
	c.JSON(http.StatusOK, user)
}
