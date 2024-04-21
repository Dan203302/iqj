package handlers

import (
	"fmt"
	"iqj/database"
	"iqj/models"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

// Получает offset и count из запроса, вызывает функцию GetLatestNewsBlocks,
// которая вернет массив с последними новостями.
// Выдает новости пользователю в формате JSON.
// Например при GET /news?offset=1&count=5 вернет новости с первой по шестую.
func HandleGetNews(c *gin.Context) {
	// Получаем промежуток пропуска и количество блоков новостей
	offsetStr := c.Query("offset")
	countStr := c.Query("count")

	offset, err := strconv.Atoi(offsetStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, err.Error())
		return
	}
	count, err := strconv.Atoi(countStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, err.Error())
		return
	}

	latestnews, err := database.Database.GetLatestNewsBlocks(offset, count)
	if err != nil {
		c.JSON(http.StatusInternalServerError, "")
	}
	c.JSON(http.StatusOK, latestnews)
}

// Извлекает id из параметров запроса,
// вызывает функцию GetNewsByID, которая получает полную новость из бд.
// Выдает полную новость пользователю в формате JSON.
// Например при GET /newsid?id=13 вернет новость с id = 13.
func HandleGetNewsById(c *gin.Context) {
	idStr := c.Query("id")

	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
	}

	news, err := database.Database.GetNewsByID(id)
	if err != nil {
		fmt.Println(err)
	}
	c.JSON(http.StatusOK, news)
}

func HandleAddNews(c *gin.Context) {
	userIdToConv, exists := c.Get("userId")
	if !exists {
		c.JSON(http.StatusUnauthorized, "User ID not found")
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
		var news struct {
			models.NewsBlock
			Text string
		}
		err := c.BindJSON(&news)
		if err != nil {
			c.JSON(http.StatusBadRequest, err.Error())
		}
		newsBl := models.NewsBlock{Header: news.Header, ImageLink: news.ImageLink, Link: "", Tags: news.Tags, PublicationTime: news.PublicationTime}
		ok := database.Database.AddNews(newsBl, news.Text)
		if ok != nil {
			c.JSON(http.StatusInternalServerError, ok.Error())
		}
		c.JSON(http.StatusOK, news)
	} else {
		c.JSON(http.StatusForbidden, "There are not enough rights for this action")
	}
}
