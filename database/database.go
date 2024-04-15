package database

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	"iqj/config"
	"sync"
)

var Database Storage

type Storage struct {
	Db    *sql.DB
	Mutex sync.Mutex
}

func ConnectStorage() {
	Database.createStorage()
}

func (st *Storage) createStorage() {

	/* пример содержания файла /iqj/config/config.go:
	package config

	var DbData = []interface{}{"hostname", "port", "user", "password", "dbname"}
	*/
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
	st.Mutex = sync.Mutex{}

	err = db.Ping()
	if err != nil {
		panic(fmt.Sprintf("could not ping the database: %v", err))
	}

	st.initTables()
}

func (st *Storage) initTables() {
	st.initNewsTable()
	st.initUsersTable()
	st.initScheduleTable()
	st.initStudentGroupsTable()
	st.initTeachersTable()
	st.initStudentsTable()
}

func (st *Storage) initNewsTable() {
	_, err := st.Db.Exec(`
		CREATE TABLE IF NOT EXISTS news (
			id SERIAL PRIMARY KEY,
			header VARCHAR(255) NOT NULL,
			link VARCHAR(255) NOT NULL,
		    news_text TEXT not null,
		    image_link TEXT[],
		    publication_time TIMESTAMP
		    
		);
	`)
	if err != nil {
		panic(fmt.Sprintf("could not create 'news' table: %v", err))
	}

}

func (st *Storage) initUsersTable() {
	_, err := st.Db.Exec(`
		CREATE TABLE IF NOT EXISTS users (
			id SERIAL PRIMARY KEY,
			name VARCHAR(255) NOT NULL,
		    email VARCHAR(255) NOT NULL UNIQUE,
			password TEXT NOT NULL,
		    role VARCHAR(20)
		    
		);
	`)
	if err != nil {
		panic(fmt.Sprintf("could not create 'users' table: %v", err))
	}

}

func (st *Storage) initStudentsTable() {
	_, err := st.Db.Exec(`
		CREATE TABLE IF NOT EXISTS students (
			id INT PRIMARY KEY,
			student_group INT NOT NULL,
			teachers JSON		    
		);
	`)
	if err != nil {
		panic(fmt.Sprintf("could not create 'students' table: %v", err))
	}

}

func (st *Storage) initTeachersTable() {
	_, err := st.Db.Exec(`
		CREATE TABLE IF NOT EXISTS teachers (
			id INT PRIMARY KEY,
			student_groups JSON		    
		);
	`)
	if err != nil {
		panic(fmt.Sprintf("could not create 'teachers' table: %v", err))
	}
}

func (st *Storage) initStudentGroupsTable() {
	_, err := st.Db.Exec(`
		CREATE TABLE IF NOT EXISTS student_groups (
			id SERIAL PRIMARY KEY,
			grade INT NOT NULL,
			institute VARCHAR(128) NOT NULL,
		    name VARCHAR(10) NOT NULL,
		    students JSON		    
		);
	`)
	if err != nil {
		panic(fmt.Sprintf("could not create 'student_groups' table: %v", err))
	}

}

func (st *Storage) initScheduleTable() {
	_, err := st.Db.Exec(`
		CREATE TABLE IF NOT EXISTS schedule (
			id SERIAL PRIMARY KEY,
			group_id INT NOT NULL,
			teacher_id INT NOT NULL,
		    weekday INT NOT NULL,
		    discipline_name VARCHAR (128),
		    lesson_count INT NOT NULL,		    
		    location VARCHAR(12) NOT NULL
		);
	`)
	if err != nil {
		panic(fmt.Sprintf("could not create 'schedule' table: %v", err))
	}

}

func (st *Storage) initAdTable() {
	_, err := st.Db.Exec(`
		CREATE TABLE IF NOT EXISTS ad (
			id SERIAL PRIMARY KEY, 
			content TEXT NOT NULL
		);
	`)
	if err != nil {
		panic(fmt.Sprintf("could not create 'ad' table: %v", err))
	}
}
