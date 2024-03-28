package handlers

import (
	"encoding/json"
	"golang.org/x/crypto/bcrypt"
	"iqj/api"
	"iqj/models"
	"net/http"
)

func HandleSignUp(w http.ResponseWriter, r *http.Request) {
	var user models.UserData
	err := json.NewDecoder(r.Body).Decode(&user)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
	}
	password := user.Password
	hashedpassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
	user.Password = string(hashedpassword)
	// TODO сделать добавление email и password в бд
	api.WriteJSON(w, http.StatusOK, user)
}
