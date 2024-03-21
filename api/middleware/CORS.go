package middleware

import "net/http"

// Middleware, который позволяет клиентам с разных источников безопасно взаимодействовать с вашим API.
// Он устанавливает необходимые заголовки CORS в HTTP-ответах.
func CORSMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Origin, Content-Type")

		// Проверка на предварительный запрос (preflight request) с методом OPTIONS.
		// Если это предварительный запрос, обработчик отправляет ответ со статусом 200 OK и возвращает управление.
		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}

		// Для всех остальных запросов вызывается следующий обработчик в цепочке.
		next.ServeHTTP(w, r)
	})
}
