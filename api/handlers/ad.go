package handlers

import (
	"github.com/gin-gonic/gin"
	"iqj/models"
)

func HandleGetAd(c *gin.Context) {
	var ad models.Ad
	c.Bind(&ad)

}

func HandlePostAd(c *gin.Context) {

}
