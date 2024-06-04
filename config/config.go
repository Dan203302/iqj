package config

var DbData = map[string]string{
	"host":     "localhost",
	"port":     "8080",
	"user":     "postgres",
	"password": "ghbdtn",
	"database": "postgres",
}

const SigningKey = ("YIyahj46a-cbxhR5o")

var SertificatePath = "C:/Users/ddm22/OneDrive/Рабочий стол/config_iqj/certificate.crt"

var KeyPath = "C:/Users/ddm22/OneDrive/Рабочий стол/config_iqj/key.crt"

// package main

// import (
// 	"fmt"
// 	"io"
// 	"net/http"

// 	//"github.com/gorilla/websocket"
// 	"golang.org/x/net/websocket"
// )

// type Server struct {
// 	conns map[*websocket.Conn]bool
// }

// func NewServer() *Server {
// 	return &Server{
// 		conns: make(map[*websocket.Conn]bool),
// 	}
// }

// func (s *Server) handlWS(ws *websocket.Conn) {
// 	fmt.Println("new connecting", ws.RemoteAddr())
// 	s.conns[ws] = true

// 	s.readLoop(ws)
// }

// func (s *Server) readLoop(ws *websocket.Conn) {
// 	buf := make([]byte, 1024)
// 	for {
// 		n, err := ws.Read(buf)
// 		if err != nil {
// 			if err == io.EOF {
// 				break
// 			}
// 			fmt.Println("read error", err)
// 			continue
// 		}
// 		msg := buf[:n]
// 		// fmt.Println(string(msg))
// 		// ws.Write([]byte("u writed a msg"))
// 		s.broadcast(msg)
// 	}
// }

// func (s *Server) broadcast(b []byte) {
// 	for ws := range s.conns {
// 		go func(ws *websocket.Conn) {
// 			if _, err := ws.Write(b); err != nil {
// 				fmt.Println("write error", err)
// 			}
// 		}(ws)
// 	}
// }

// func main() {
// 	server := NewServer()
// 	http.Handle("/ws", websocket.Handler(server.handlWS))
// 	http.ListenAndServe(":5037", nil)
// }
