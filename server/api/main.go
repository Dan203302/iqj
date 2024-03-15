package main

import (
        "encoding/json"
        "fmt"
        "github.com/gorilla/mux"
        "iqj/database"
        "iqj/server/scraper"
        "log"
        "net/http"
        "strconv"
)

// Получает offset и count из запроса, вызывает функцию GetLatestNewsBlocks,
// которая вернет массив с последними новостями.
// Выдает новости пользователю в формате JSON.
// Например при GET /news?offset=1&count=5 вернет новости с первой по шестую.
func handleGetNews(w http.ResponseWriter, r *http.Request) {
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
	
        latestnewsptr, err := database.Database.GetLatestNewsBlocks(offset, count)
        latestnews := *latestnewsptr
        if err != nil {
                fmt.Println(err)
        }
        WriteJSON(w, http.StatusOK, latestnews)
}

// Извлекает id из параметров запроса,
// вызывает функцию GetNewsByID, которая получает полную новость из бд.
// Выдает полную новость пользователю в формате JSON.
// Например при GET /news/13 вернет новость с id = 13.
func handleGetNewsById(w http.ResponseWriter, r *http.Request) {
        idstr := mux.Vars(r)["id"]
        id, err := strconv.Atoi(idstr)
        if err != nil {
                fmt.Println(err)
        }
        newsptr, err := database.Database.GetNewsByID(id)
        news := *newsptr
        if err != nil {
                fmt.Println(err)
        }
        WriteJSON(w, http.StatusOK, news)
}

func main() {
        // БД
        database.ConnectStorage()

        // Запускает парсер новостей
        go scraper.ScrapTick()

        // Создание роутера.
        router := mux.NewRouter()
        // Вызов хэндлеров исходя из запроса.
        router.HandleFunc("/news", handleGetNews)
        router.HandleFunc("/news/{id}", handleGetNewsById)
        // Запускает сервер на порту и "слушает" запросы.
        if err := http.ListenAndServe(":3333", router); err != nil {
                log.Fatal(err)
        }
}

// Отправляет данные пользователю в формате JSON через http ответ.
func WriteJSON(w http.ResponseWriter, status int, v any) error {
        w.Header().Add("Content-Type", "application/json")
        w.WriteHeader(status)
        return json.NewEncoder(w).Encode(v)
}


