package databaserework

import (
	"database/sql"
	"fmt"
)

type queryMaker struct{}

func (qm *queryMaker) makeSelect(db *sql.DB, query string, keys ...interface{}) (*sql.Rows, error) {

	rows, err := db.Query(query, keys...)

	if err != nil {
		return nil, fmt.Errorf("problem with selecting! %v\ncaused by: %v", err, query)
	}

	return rows, nil
}

func (qm *queryMaker) makeInsert(db *sql.DB, query string, values ...interface{}) error {

	// Выполняем дефолтный инсерт в базу данных (вставка в таблицу)
	_, err := db.Exec(query,
		values...)

	if err != nil {
		return fmt.Errorf("problem with inserting! %v\ncaused by: %v", err, query)
	}

	return nil
}

func (qm *queryMaker) makeUpdate(db *sql.DB, query string, key interface{}, values ...interface{}) error {

	values = append(values, &key)

	_, err := db.Exec(query,
		values...)

	if err != nil {
		return fmt.Errorf("problem with updating! %v\ncaused by: %v", err, query)
	}

	return nil
}

func (qm *queryMaker) makeDelete(db *sql.DB, query string, key interface{}) error {

	_, err := db.Exec(query, key)
	if err != nil {
		return fmt.Errorf("problem with deleting! %v\ncaused by: %v", err, query)
	}

	return nil
}
