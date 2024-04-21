package databaserework

import (
	"database/sql"
	"errors"
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

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
	tm *transactionMaker
}

func (ut *userTable) Add(u *User) error {

	// Проверяем были ли переданы данные в u
	if u.isDefault() {
		return errors.New("User.Add: wrong data! provided *User is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := ut.tm.makeInsert(ut.db,
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

	rows, err := ut.tm.makeSelect(ut.db, "SELECT Email, Password FROM Users WHERE UserId = $1", u.Id)
	if err != nil {
		return nil, fmt.Errorf("User.Get: %v", err)
	}
	defer rows.Close()
	// TODO: исправить условие снизу
	if rows.Next() {
		if err := rows.Scan(&u.Email, &u.Password); err != nil {
			return nil, err
		}
	} else {
		return nil, errors.New("User.Get: no rows returned")
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

	rows, err := ut.tm.makeSelect(ut.db, "SELECT Password, Id FROM Users WHERE Email = $1", u.Email)
	if err != nil {
		return nil, fmt.Errorf("User.Check: %v", err)
	}
	defer rows.Close()
	// TODO: исправить условие снизу
	if rows.Next() {
		if err := rows.Scan(&pass, &id); err != nil {
			return nil, err
		}
	} else {
		return nil, errors.New("User.Check: no rows returned")
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
	err := ut.tm.makeDelete(ut.db, "DELETE FROM Users WHERE UserId = $1", u.Id)

	if err != nil {
		return fmt.Errorf("User.Delete: %v", err)
	}

	return nil
}
