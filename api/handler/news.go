package handler

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"iqj/database"
	"net/http"
	"strconv"
)

// Получает offset и count из запроса, вызывает функцию GetLatestNewsBlocks,
// которая вернет массив с последними новостями.
// Выдает новости пользователю в формате JSON.
// Например при GET /news?offset=1&count=5 вернет новости с первой по шестую.
func (h *Handler) HandleGetNews(c *gin.Context) {
	// Получаем промежуток пропуска и количество блоков новостей
	offsetStr := c.Query("offset")
	countStr := c.Query("count")

	offset, err := strconv.Atoi(offsetStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, err.Error())
		return
	}
	switch {
	case offset < 0:
		c.JSON(http.StatusBadRequest, "Offset < 0")
		return
	case offset > 999999:
		c.JSON(http.StatusBadRequest, "Offset > 999999")
		return
	}

	count, err := strconv.Atoi(countStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, err.Error())
		return
	}
	switch {
	case count < 1:
		c.JSON(http.StatusBadRequest, "Count < 1")
		return
	case count > 999999:
		c.JSON(http.StatusBadRequest, "Count > 999999")
		return
	}

	latestnews, err := database.Database.News.GetLatestBlocks(offset, count)
	if err != nil {
		c.JSON(http.StatusInternalServerError, "")
	}
	c.JSON(http.StatusOK, latestnews)
}

// Извлекает id из параметров запроса,
// вызывает функцию GetNewsByID, которая получает полную новость из бд.
// Выдает полную новость пользователю в формате JSON.
// Например при GET /newsid?id=13 вернет новость с id = 13.
func (h *Handler) HandleGetNewsById(c *gin.Context) {
	idStr := c.Query("id")

	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
	}
	switch {
	case id < 0:
		c.JSON(http.StatusBadRequest, "Id < 0")
		return
	case id > 999999:
		c.JSON(http.StatusBadRequest, "Id > 999999")
		return
	}

	var newsDB database.News
	newsDB.Id = id

	news, err := database.Database.News.GetById(&newsDB)
	if err != nil {
		fmt.Println(err)
	}
	c.JSON(http.StatusOK, news)
}

func (h *Handler) HandleAddNews(c *gin.Context) {
	userIdToConv, exists := c.Get("userId")
	if !exists {
		c.JSON(http.StatusUnauthorized, "User ID not found")
		return
	}
	userId := userIdToConv.(int)
	var userDB database.UserData
	userDB.Id = userId
	user, err := database.Database.UserData.GetRoleById(&userDB)
	if err != nil {
		c.JSON(http.StatusInternalServerError, "")
	}
	if user.Role == "moderator" {
		var news database.News
		err := c.BindJSON(&news)
		if err != nil {
			c.JSON(http.StatusBadRequest, err.Error())
		}
		ok := database.Database.News.Add(&news)
		if ok != nil {
			c.JSON(http.StatusInternalServerError, ok.Error())
		}
		c.JSON(http.StatusOK, news)
	} else {
		c.JSON(http.StatusForbidden, "There are not enough rights for this action")
	}
}
