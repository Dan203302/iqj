package database

import (
	"database/sql"
	"fmt"
	"iqj/config"
)

var Database Storage

type Storage struct {
	Db *sql.DB
}

func ConnectStorage() {
	Database.createStorage()
}

func (store *Storage) createStorage() {
	// TODO: В папке /iqj/config/ должен храниться файл с данными для запуска бд (хост, порт, имя и пароль от пользователя, а также название базы
	/* пример содержания файла /iqj/config/config.go:
	package config

	var DbData = []interface{}{"hostname", "port", "user", "password", "dbname"}
	*/
	connectionString := fmt.Sprintf("host=%v port=%v user=%v password=%v dbname=%v sslmode=disable", config.DbData...)

	db, err := sql.Open("postgres", connectionString)

	if err != nil {
		panic("could not connect to the database")
	}

	store.Db = db

	err = db.Ping()
	if err != nil {
		panic(fmt.Sprintf("could not ping the database: %v", err))
	}

	store.initTables()
}

func (st *Storage) initTables() {
	_, err := st.Db.Exec(`
		CREATE TABLE IF NOT EXISTS news (
			id SERIAL PRIMARY KEY,
			header VARCHAR(255) NOT NULL,
			link VARCHAR(255) NOT NULL,
		    news_text TEXT not null,
		    image_link TEXT,
		    publication_time TIMESTAMP
		    
		);
	`)
	if err != nil {
		panic(fmt.Sprintf("could not create 'news' table: %v", err))
	}

}
