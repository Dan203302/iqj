package main

import (
	"database/sql"
	//"fmt"
	"io"
	"log"
	"net/http"

	"github.com/gorilla/websocket"
	_ "github.com/lib/pq"
)

type Server struct {
	conns map[*websocket.Conn]bool
	db    *sql.DB
}

func NewServer(db *sql.DB) *Server {
	return &Server{
		conns: make(map[*websocket.Conn]bool),
		db:    db,
	}
}

func (s *Server) handleWS(w http.ResponseWriter, r *http.Request) {
	// Инициализация соединения WebSocket.
	ws, err := websocket.Upgrade(w, r, nil, 1024, 1024)
	if err != nil {
		http.Error(w, "Failed to upgrade to WebSocket", http.StatusBadRequest)
		return
	}

	// Добавление подключения к серверу.
	s.conns[ws] = true

	// Запуск чтения сообщений из WebSocket.
	s.readLoop(ws)
}

func (s *Server) readLoop(ws *websocket.Conn) {
	for {
		// Чтение сообщения из WebSocket.
		_, message, err := ws.ReadMessage()
		if err != nil {
			if err == io.EOF {
				break
			}
			log.Println("Read error:", err)
			continue
		}

		// Рассылка сообщения всем клиентам.
		s.broadcast(message)
	}
}

func (s *Server) broadcast(message []byte) {
	for conn := range s.conns {
		err := conn.WriteMessage(websocket.TextMessage, message)
		if err != nil {
			log.Println("Write error:", err)
		}
	}
}

func main() {
	// Подключение к базе данных PostgreSQL.
	db, err := sql.Open("postgres", "postgres://user:password@localhost:5432/database?sslmode=disable")
	if err != nil {
		log.Fatal("Database connection failed:", err)
	}
	defer db.Close()

	// Создание сервера WebSocket.
	server := NewServer(db)

	// Зарегистрировать обработчик WebSocket.
	http.HandleFunc("/ws", server.handleWS)

	// Запуск HTTP сервера.
	log.Println("Server is running on http://localhost:8080/ws")
	err = http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal("Server startup failed:", err)
	}
}
