package databaserework

import (
	"database/sql"
	"fmt"
)

type transactionMaker struct{}

func (tm *transactionMaker) makeSelect(db *sql.DB, query string, key interface{}) (*sql.Rows, error) {
	tx, err := db.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	rows, err := tx.Query(query, key)
	if err != nil {
		return nil, fmt.Errorf("problem with selecting! %v\ncaused by: %v", err, query)
	}

	if err := tx.Commit(); err != nil {
		rows.Close()
		return nil, err
	}

	return rows, nil
}

func (tm *transactionMaker) makeInsert(db *sql.DB, query string, values ...interface{}) error {
	tx, err := db.Begin()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	_, err = tx.Exec(query, values...)
	if err != nil {
		return fmt.Errorf("problem with inserting! %v\ncaused by: %v", err, query)
	}

	if err := tx.Commit(); err != nil {
		return err
	}

	return nil
}

func (tm *transactionMaker) makeUpdate(db *sql.DB, query string, key interface{}, values ...interface{}) error {
	tx, err := db.Begin()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	values = append(values, &key)

	_, err = tx.Exec(query, values...)
	if err != nil {
		return fmt.Errorf("problem with updating! %v\ncaused by: %v", err, query)
	}

	if err := tx.Commit(); err != nil {
		return err
	}

	return nil
}

func (tm *transactionMaker) makeDelete(db *sql.DB, query string, key interface{}) error {
	tx, err := db.Begin()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	_, err = tx.Exec(query, key)
	if err != nil {
		return fmt.Errorf("problem with deleting! %v\ncaused by: %v", err, query)
	}

	if err := tx.Commit(); err != nil {
		return err
	}

	return nil
}
