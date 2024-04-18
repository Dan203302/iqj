package databaserework

import (
	"database/sql"
	"sync"
)

type newsTable struct {
	db *sql.DB
	mu *sync.Mutex
}

func (n *newsTable) Add() {}

func (ut *newsTable) new(db *sql.DB, mu *sync.Mutex) {
	ut.db, ut.mu = db, mu
}
