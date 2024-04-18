package databaserework

import (
	"database/sql"
	"fmt"
	"sync"
)

type Database123 struct {
	Users *usersModel
	News  *newsModel
}

type usersModel struct {
	db   *sql.DB
	lock *sync.Mutex
}

type newsModel struct {
	db   *sql.DB
	lock *sync.Mutex
}

type TableModel interface {
	connect(func())
}

func (n *newsModel) Add() {}

func (u *usersModel) Add() {}

var Database2 Database123

func ConnectStorage() {
	Database2.setupConnection()
}

func (st *Database123) setupConnection(connectionString string) {
	// connectionString := fmt.Sprintf(
	// 	"host=%v port=%v user=%v password=%v dbname=%v sslmode=disable",
	// 	config.DbData["host"],
	// 	config.DbData["port"],
	// 	config.DbData["user"],
	// 	config.DbData["password"],
	// 	config.DbData["database"])

	db, err := sql.Open("postgres", connectionString)

	if err != nil {
		panic(fmt.Sprintf("could not connect to the database: %v", err))
	}

	mutex := &sync.Mutex{}

	st.Users.connect(db, mutex)
	st.News.connect(db, mutex)

	err = db.Ping()
	if err != nil {
		panic(fmt.Sprintf("could not ping the database: %v", err))
	}
}

func (st *Database123) connectTables(db *sql.DB, mutex *sync.Mutex) {
	st.Users.connect(db, mutex)
	st.News.connect(db, mutex)
}
