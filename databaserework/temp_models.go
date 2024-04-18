package databaserework

import (
	"database/sql"
	"fmt"
	"iqj/config"
)

type Database123 struct {
	Users *users
}

type users struct{}

type userModel struct {
	Db *sql.DB
}

type newsModel struct {
	Db *sql.DB
}

type Table interface {
	Add(func())
}

var Database2 Database123

func ConnectStorage() {
	Database2.createStorage()
}

func (st *Database123) createStorage() {
	connectionString := fmt.Sprintf(
		"host=%v port=%v user=%v password=%v dbname=%v sslmode=disable",
		config.DbData["host"],
		config.DbData["port"],
		config.DbData["user"],
		config.DbData["password"],
		config.DbData["database"])

	db, err := sql.Open("postgres", connectionString)

	if err != nil {
		panic(fmt.Sprintf("could not connect to the database: %v", err))
	}

	st.Db = db
	st.Mutex
}

var user123 = users{}

type Filter struct {
	// Keys приводите только нужные параметры!!!
	Keys map[string]interface{}
}

func lol() {
	varia := Filter{Keys: map[string]interface{}{}}
	varia.Keys = map[string]interface{}{}
}
