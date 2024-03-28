package handlers

import (
	"encoding/json"
	"fmt"
	"iqj/api/middleware"
	"iqj/database"
	"iqj/models"
	"net/http"
)

// Вход в систему
// Получаем данные, введенные пользователем из тела запроса и записываем их
// Возвращаем JWT
func HandleSignIn(w http.ResponseWriter, r *http.Request) {

	// TODO: сваггер подправить под это

	// Получаем данные, введенные пользователем из тела запроса и записываем их в signingUser
	var signingUser models.User
	err := json.NewDecoder(r.Body).Decode(&signingUser.Data)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
	}

	// Проверяем существует ли такой пользователь и проверяем верный ли пароль
	err = database.Database.CheckUser(&signingUser)
	if err != nil {
		WriteJSON(w, http.StatusUnauthorized, "") // Если пользователя нет или пароль неверный вернем пустую строку и ошибку
	}

	// Если все хорошо сделаем JWT токен

	// Получаем токен для пользователя
	token, err := middleware.GenerateJWT()
	if err != nil {
		fmt.Println(err)
	}

	//Выводим токен в формате JSON
	WriteJSON(w, http.StatusOK, token)
}
