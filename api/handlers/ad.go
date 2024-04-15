package handlers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"iqj/database"
	"iqj/models"
	"net/http"
	"strconv"
)

func HandleGetAd(c *gin.Context) {
	countStr := c.Query("count")
	count, ok := strconv.Atoi(countStr)
	if ok != nil {
		c.JSON(http.StatusBadRequest, ok.Error())
		return
	}

	ads, err := database.Database.GetAd(count)
	fmt.Println(ads)
	if err != nil {
		c.String(http.StatusInternalServerError, "")
	}
	c.JSON(http.StatusOK, ads)
}

func HandlePostAd(c *gin.Context) {
	userIdToConv, ok := c.Get("userId")
	if !ok {
		c.String(http.StatusUnauthorized, "User ID not found")
		return
	}
	userId := userIdToConv.(int)

	user, err := database.Database.GetRole( // у этого юзера будет роль, все хорошо -> user.Role
		&models.User{
			Id: userId,
		})
	if err != nil {
		c.JSON(http.StatusInternalServerError, "")
	}

	if user.Role == "moderator" {
		var ad models.Ad

		err := c.BindJSON(&ad)
		if err != nil {
			c.String(http.StatusBadRequest, err.Error())
		}

		ok := database.Database.AddAd(ad)
		if ok != nil {
			c.JSON(http.StatusInternalServerError, ok.Error())
		}

		c.JSON(http.StatusOK, ad)
	} else {
		c.JSON(http.StatusForbidden, "There are not enough rights for this action")
	}
}
