package handlers

import (
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
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
	// TODO сделать добавление email и password в бд
	c.JSON(http.StatusOK, user)
}
