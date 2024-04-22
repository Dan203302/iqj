package handler

import (
	"fmt"
	"iqj/database"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func (h *Handler) HandleGetAd(c *gin.Context) {
	idStr := c.Query("id")
	id, ok := strconv.Atoi(idStr)
	if ok != nil {
		c.JSON(http.StatusBadRequest, ok.Error())
		return
	}

	var advertisementBD database.Advertisement
	advertisementBD.Id = id
	if advertisementBD.Id != 0 {
		advertisement, err := database.Database.Advertisement.GetById(&advertisementBD) // TODO: что за count? надо комментарии и GetById
		fmt.Println(advertisement)
		if err != nil {
			c.String(http.StatusInternalServerError, "")
		}
		c.JSON(http.StatusOK, advertisement)
	}
}

func (h *Handler) HandlePostAd(c *gin.Context) {
	userIdToConv, ok := c.Get("userId")
	if !ok {
		c.String(http.StatusUnauthorized, "User ID not found")
		return
	}
	userId := userIdToConv.(int)

	user, err := database.Database.UserData.GetRoleById( // у этого юзера будет роль, все хорошо -> user.Role
		&database.UserData{
			Id: userId,
		})
	if err != nil {
		c.JSON(http.StatusInternalServerError, "")
	}

	if user.Role == "moderator" {
		var advertisement database.Advertisement // TODO: исправить

		err := c.BindJSON(&advertisement)
		if err != nil {
			c.String(http.StatusBadRequest, err.Error())
		}

		ok := database.Database.Advertisement.Add(&advertisement)
		if ok != nil {
			c.JSON(http.StatusInternalServerError, ok.Error())
		}

		c.JSON(http.StatusOK, advertisement)
	} else {
		c.JSON(http.StatusForbidden, "There are not enough rights for this action")
	}
}
