package handlers

import (
	"fmt"
	"iqj/api"
	"iqj/database"
	"net/http"
	"strconv"
)

// Получает offset и count из запроса, вызывает функцию GetLatestNewsBlocks,
// которая вернет массив с последними новостями.
// Выдает новости пользователю в формате JSON.
// Например при GET /news?offset=1&count=5 вернет новости с первой по шестую.
func HandleGetNews(w http.ResponseWriter, r *http.Request) {
	// Получаем промежуток пропуска и количество блоков новостей
	offsetStr := r.URL.Query().Get("offset")
	countStr := r.URL.Query().Get("count")

	offset, err := strconv.Atoi(offsetStr)
	if err != nil {
		http.Error(w, "Invalid offset parameter", http.StatusBadRequest)
		return
	}
	count, err := strconv.Atoi(countStr)
	if err != nil {
		http.Error(w, "Invalid count parameter", http.StatusBadRequest)
		return
	}

	latestnews, err := database.Database.GetLatestNewsBlocks(offset, count)
	if err != nil {
		fmt.Println(err)
	}
	api.WriteJSON(w, http.StatusOK, latestnews)
}

// Извлекает id из параметров запроса,
// вызывает функцию GetNewsByID, которая получает полную новость из бд.
// Выдает полную новость пользователю в формате JSON.
// Например при GET /newsid?id=13 вернет новость с id = 13.
func HandleGetNewsById(w http.ResponseWriter, r *http.Request) {
	idStr := r.URL.Query().Get("id")

	id, err := strconv.Atoi(idStr)
	if err != nil {
		fmt.Println(err)
	}

	news, err := database.Database.GetNewsByID(id)
	if err != nil {
		fmt.Println(err)
	}
	api.WriteJSON(w, http.StatusOK, news)
}
