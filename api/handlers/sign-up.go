package handlers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
	"iqj/database"
	"iqj/models"
	"net/http"
)

func HandleSignUp(c *gin.Context) {
	var user models.User

	ok := c.BindJSON(&user)
	if ok != nil {
		c.String(http.StatusBadRequest, ok.Error())
	}

	password := user.Data.Password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
	}

	user.Data.Password = string(hashedPassword)

	if err = database.Database.AddUser(&user); err != nil {
		fmt.Println(err)
	}

	c.JSON(http.StatusOK, user)
}
