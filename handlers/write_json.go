package handlers

import (
	"encoding/json"
	"net/http"
)

// Отправляет данные пользователю в формате JSON через http ответ.
func WriteJSON(w http.ResponseWriter, status int, v any) error {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(status)
	return json.NewEncoder(w).Encode(v)
}
