package middleware

import (
	"errors"
	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"iqj/config"
	"net/http"
	"strings"
	"time"
)

// Структура для параметров JWT
type tokenclaims struct {
	jwt.MapClaims
	UserId int `json:"user_id"`
}

// Если с токеном все хорошо,вызовется функция, которая находится внутри.
// Например для WithJWTAuth(handleHello) при правильном токене следом сработает handleHello
func WithJWTAuth() gin.HandlerFunc {
	return func(c *gin.Context) {
		// Получаем значение заголовка Authorization
		header := c.GetHeader("Authorization")

		// Проверяем не пустое ли значение в поле заголовка
		if header == "" {
			c.JSON(http.StatusUnauthorized, "Missing auth token")
			return
		}

		// Отделяем тип от токена(изначально у нас header выглядит так:
		//Bearer eyJhbGciOiJIU и так далее).
		tokenstring := strings.Split(header, " ")
		// Проверяем, что у нас есть и тип и сам токен
		if len(tokenstring) != 2 {
			c.JSON(http.StatusUnauthorized, "Invalid auth header")
			return
		}

		//Парсим токен, взяв из заголовка только токен
		token, err := jwt.ParseWithClaims(tokenstring[1], &tokenclaims{}, func(token *jwt.Token) (interface{}, error) {
			// Проверяем метод подписи токена
			if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
				return nil, errors.New("invalid signing method")
			}
			return []byte(config.SigningKey), nil
		})

		if err != nil {
			c.JSON(http.StatusForbidden, err.Error())
			return
		}

		// Проверяем что токен действителен
		if !token.Valid {
			c.JSON(http.StatusForbidden, "bad token")
			return
		}

		claims, ok := token.Claims.(*tokenclaims)
		if !ok {
			c.JSON(http.StatusForbidden, err.Error())
		}

		// Записываем id в контекст, чтобы в дальнейшем использовать в других функциях
		c.Set("userId", claims.UserId)
		// Если все хорошо, у нас вызывается функция, которая передавалась в WithJWTAuth
		c.Next()
	}
}

// Создание токена
func GenerateJWT(id int) (string, error) {
	claims := &tokenclaims{
		jwt.MapClaims{
			"ExpiresAt": time.Now().Add(24 * time.Hour).Unix(), // Через сколько токен станет недействительный
			"IssuedAr":  time.Now().Unix(),                     // Время, когда был создан токен
		},
		id,
	}
	// Создание токена с параметрами записанными в claims и id пользователя
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	// Создание какой-то JWT строчки
	return token.SignedString([]byte(config.SigningKey))
}
