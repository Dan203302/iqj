package handlers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"iqj/database"
	"iqj/models"
	"net/http"
	"strconv"
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
		c.String(http.StatusBadRequest, err.Error())
		return
	}
	count, err := strconv.Atoi(countStr)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
		return
	}

	latestnews, err := database.Database.GetLatestNewsBlocks(offset, count)
	if err != nil {
		fmt.Println(err)
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
	//userId, exists := c.Get("userId")
	//if !exists {
	//	c.JSON(http.StatusUnauthorized, "User ID not found")
	//	return
	//}

	// TODO сделать проверку роли пользователя из бд

	var news struct {
		Header string `json:"header"`
		Text   string `json:"text"`
	}
	c.BindJSON(&news)
	newsbl := models.NewsBlock{Header: news.Header, ImageLink: []string{}, Link: "", PublicationTime: ""}
	database.Database.AddNews(newsbl, news.Text)
	c.JSON(http.StatusOK, news)
}
