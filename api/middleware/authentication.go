package middleware

import (
	"errors"
	"github.com/dgrijalva/jwt-go"
	"iqj"
	"iqj/api/handlers"
	"net/http"
	"strings"
	"time"
)

// Структура для параметров JWT
type tokenclaims struct {
	jwt.MapClaims
}

// Если с токеном все хорошо,вызовется функция, которая находится внутри.
// Например для WithJWTAuth(handleHello) при правильном токене следом сработает handleHello
func WithJWTAuth(handlerFunc http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// Получаем значение заголовка Authorization
		header := r.Header.Get("Authorization")

		// Проверяем не пустое ли значение в поле заголовка
		if header == "" {
			http.Error(w, "Missing auth token", http.StatusUnauthorized)
			return
		}

		// Отделяем тип от токена(изначально у нас header выглядит так:
		//Bearer eyJhbGciOiJIU и так далее).
		tokenstring := strings.Split(header, " ")
		// Проверяем, что у нас есть и тип и сам токен
		if len(tokenstring) != 2 {
			http.Error(w, "Invalid auth header", http.StatusUnauthorized)
			return
		}

		//Парсим токен, взяв из заголовка только токен
		token, err := jwt.Parse(tokenstring[1], func(token *jwt.Token) (interface{}, error) {
			// Проверяем метод подписи токена
			if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
				return nil, errors.New("invalid signing method")
			}
			return []byte(iqj.SigningKey), nil
		})

		if err != nil {
			handlers.WriteJSON(w, http.StatusForbidden, err.Error())
			return
		}

		// Проверяем что токен действителен
		if !token.Valid {
			handlers.WriteJSON(w, http.StatusForbidden, "bad token")
			return
		}

		// Если все хорошо, у нас вызывается функция, которая передавалась в WithJWTAuth
		handlerFunc(w, r)
	}
}

// Создание токена
func GenerateJWT() (string, error) {
	claims := &tokenclaims{
		jwt.MapClaims{
			"ExpiresAt": time.Now().Add(24 * time.Hour).Unix(), // Через сколько токен станет недействительный
			"IssuedAr":  time.Now().Unix(),                     // Время, когда был создан токен
		},
	}
	// Создание токена с параметрами записанными в claims и id пользователя
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	// Создание какой-то JWT строчки
	return token.SignedString([]byte(iqj.SigningKey))
}
