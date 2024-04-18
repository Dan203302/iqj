package databaserework

import (
	"database/sql"
	"sync"
)

func (u *usersModel) connect(db *sql.DB, mutex *sync.Mutex)
