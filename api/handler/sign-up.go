package handler

import (
	"fmt"
	"iqj/database"
	"net/http"

	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

func (h *Handler) HandleSignUp(c *gin.Context) {
	var user database.User

	ok := c.BindJSON(&user)
	if ok != nil {
		c.String(http.StatusBadRequest, ok.Error())
	}

	if user.Email == "" {
		c.JSON(http.StatusBadRequest, "There is no email")
	}

	if user.Password == "" {
		c.JSON(http.StatusBadRequest, "There is no password")
	}

	password := user.Password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
	}

	user.Password = string(hashedPassword)
	if err = database.Database.User.Add(&user); err != nil {
		fmt.Println(err)
	}

	c.JSON(http.StatusOK, user)
}
