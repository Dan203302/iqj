package databaserework

import (
	"database/sql"
	"sync"
)

type Database123 struct {
	Users Users
}

type Users struct {
	DB   *sql.DB
	Lock sync.Mutex
}

var Database2 Database123

func ConnectStorage() {
	Database2.createStorage()
}

func (st *Database123) createStorage() {

}

var user123 = Users{}

type Filter struct {
	// Keys приводите только нужные параметры!!!
	Keys map[string]interface{}
}

func lol() {
	varia := Filter{Keys: map[string]interface{}{}}
	varia.Keys = map[string]interface{}{}
}
