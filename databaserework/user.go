package databaserework

import (
	"database/sql"
	"errors"
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

/*
====== ТРАНЗАКЦИИ НАХОДЯТСЯ В КОНЦЕ ФАЙЛА ======
*/

// Сущность пользователя (данные о пользователе отдельно в UserData)
type User struct {
	Id       int    `json:"id"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

/*
Проверяет, переданы ли какие-либо данные в структуру.
Необходимо для реализаци интерфейса Entity, а также для фильтров в функциях БД
*/
func (u *User) isDefault() bool {
	return u.Id == 0 || u.Email == "" || u.Password == ""
}

// Структура для более удобного и понятного взаимодействия с таблицой users
type userTable struct {
	// Указатель на подключение к базе данных
	db *sql.DB
}

func (ut *userTable) Add(u *User) error {

	// Проверяем были ли переданы данные в u
	if u.isDefault() {
		return errors.New("User.Add: wrong data! provided *User is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := ut.makeInsert(
		"INSERT INTO Users (Email,Password) VALUES ($1, $2)",
		&u.Email, &u.Password,
	)

	if err != nil {
		return fmt.Errorf("User.Add: %v", err)
	}

	return nil
}

// Возвращает пользователя(массив из одного элемента) из базы данных
func (ut *userTable) GetById(u *User) (*User, error) {

	// Проверяем переданы ли данные в функцию
	if u.isDefault() {
		return nil, errors.New("User.Get: wrong data! provided *User is empty")
	}
	// Проверяем передан ли id
	if u.Id == 0 {
		return nil, errors.New("User.Get: wrong data! provided *User.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := ut.makeSelect("SELECT Email, Password FROM Users WHERE UserId = $1",
		u.Id, &u.Email, &u.Password)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("User.Get: %v", err)
	}
	return u, nil

}

func (ut *userTable) Check(u *User) (*User, error) {
	// Проверяем переданы ли данные в функцию
	if u.isDefault() {
		return nil, errors.New("User.Check: wrong data! *User is empty")
	}

	// Переменные, в которых мы будем хранить полученные данные из базы данных
	id := 0
	pass := ""

	// Для получения используем базовую функцию
	err := ut.makeSelect("SELECT Password, Id FROM Users WHERE Email = $1", u.Email, &pass, &id)

	// Проверяем ошибку
	if err != nil {
		return nil, fmt.Errorf("User.Check: %v", err)
	}

	// Сравниваем хеш из бд с тем, что мы получили из веба
	if errHash := bcrypt.CompareHashAndPassword([]byte(pass), []byte(u.Password)); errHash != nil {
		return nil, errors.New("Users.Check: incorrect password!")
	}

	// Если все хорошо, возвращаем пользователя с id
	u.Id = id
	return u, nil
}

func (ut *userTable) Delete(u *User) error {
	//  Проверяем дали ли нам нужные данные
	if u.isDefault() {
		return errors.New("User.Delete: wrong data! *User.Id is empty")
	}

	// Для удаления используем базовую функцию
	err := ut.makeDelete("DELETE FROM Users WHERE UserId = $1", u.Id)

	if err != nil {
		return fmt.Errorf("User.Delete: %v", err)
	}

	return nil
}

// ====== ТРАНЗАКЦИИ ======

func (ut *userTable) makeSelectMultiple(query string, key interface{}) (*[]User, error) {
	tx, err := ut.db.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	rows, err := tx.Query(query, key)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var users []User
	for rows.Next() {
		var user User
		if err := rows.Scan(&user.Id, &user.Email, &user.Password); err != nil {
			return nil, err
		}
		users = append(users, user)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("problem with selecting multiple values! %v", err)
	}

	if err := tx.Commit(); err != nil {
		return nil, err
	}

	return &users, nil
}

func (ut *userTable) makeSelect(query string, key interface{}, values ...interface{}) error {
	tx, err := ut.db.Begin()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	err = tx.QueryRow(query, key).Scan(values...)
	if err != nil {
		return fmt.Errorf("problem with selecting! %v", err)
	}

	if err := tx.Commit(); err != nil {
		return err
	}

	return nil
}

func (ut *userTable) makeInsert(query string, values ...interface{}) error {
	tx, err := ut.db.Begin()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	_, err = tx.Exec(query, values...)
	if err != nil {
		return fmt.Errorf("problem with inserting! %v", err)
	}

	if err := tx.Commit(); err != nil {
		return err
	}

	return nil
}

func (ut *userTable) makeUpdate(query string, key interface{}, values ...interface{}) error {
	tx, err := ut.db.Begin()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	values = append(values, &key)

	_, err = tx.Exec(query, values...)
	if err != nil {
		return fmt.Errorf("problem with updating! %v", err)
	}

	if err := tx.Commit(); err != nil {
		return err
	}

	return nil
}

func (ut *userTable) makeDelete(query string, key interface{}) error {
	tx, err := ut.db.Begin()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	_, err = tx.Exec(query, key)
	if err != nil {
		return fmt.Errorf("problem with deleting! %v", err)
	}

	if err := tx.Commit(); err != nil {
		return err
	}

	return nil
}
