package databaserework

import (
	"database/sql"
	"errors"
	"fmt"
	"sync"

	"golang.org/x/crypto/bcrypt"
)

/*
====== ЭНДПОИНТЫ НАХОДЯТСЯ В КОНЦЕ ФАЙЛА ======
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
type usersTable struct {
	// Указатель на подключение к базе данных
	db *sql.DB
	// Единый мьютекс, используемый при подключении к базе данных
	mu *sync.Mutex
}

func (ut *usersTable) Add(u *User) error {

	// Проверяем были ли переданы данные в u
	if u.isDefault() {
		return errors.New("Users.Add: wrong data! provided *User is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := ut.makeInsert(
		"INSERT INTO users (email,password) VALUES ($1, $2)",
		&u.Email, &u.Password,
	)

	if err != nil {
		return fmt.Errorf("Users.Add: %v", err)
	}

	return nil
}

// Возвращает пользователя(массив из одного элемента) из базы данных
func (ut *usersTable) GetById(u *User) (*User, error) {

	// Проверяем переданы ли данные в функцию
	if u.isDefault() {
		return nil, errors.New("Users.Get: wrong data! provided *User is empty")
	}
	// Проверяем передан ли id
	if u.Id == 0 {
		return nil, errors.New("Users.Get: wrong data! provided *User.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := ut.makeSelect("SELECT email, password FROM users WHERE id = $1",
		u.Id, &u.Email, &u.Password)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Users.Get: %v", err)
	}
	return u, nil

}

func (ut *usersTable) Check(u *User) (*User, error) {
	// Проверяем переданы ли данные в функцию
	if u.isDefault() {
		return nil, errors.New("Users.Check: wrong data! *User is empty")
	}

	// Переменные, в которых мы будем хранить полученные данные из базы данных
	id := 0
	pass := ""

	// Для получения используем базовую функцию
	err := ut.makeSelect("SELECT password, id FROM users WHERE email = $1", u.Email, &pass, &id)

	// Проверяем ошибку
	if err != nil {
		return nil, fmt.Errorf("Users.Check: %v", err)
	}

	// Сравниваем хеш из бд с тем, что мы получили из веба
	if errHash := bcrypt.CompareHashAndPassword([]byte(pass), []byte(u.Password)); errHash != nil {
		return nil, errors.New("Users.Check: incorrect password!")
	}

	// Если все хорошо, возвращаем пользователя с id
	u.Id = id
	return u, nil
}

func (ut *usersTable) Delete(u *User) error {
	//  Проверяем дали ли нам нужные данные
	if u.isDefault() {
		return errors.New("Users.Delete: wrong data! *User.Id is empty")
	}

	// Для удаления используем базовую функцию
	err := ut.makeDelete("DELETE FROM users WHERE id = $1", u.Id)

	if err != nil {
		return fmt.Errorf("Users.Delete: %v", err)
	}

	return nil
}

// ====== ЭНДПОИНТЫ ======

func (ut *usersTable) makeSelectMultiple(query string, key interface{}) (*[]User, error) {
	ut.mu.Lock()
	defer ut.mu.Unlock()

	rows, err := ut.db.Query(query, key)
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

	return &users, nil
}

func (ut *usersTable) makeSelect(query string, key interface{}, values ...interface{}) error {
	ut.mu.Lock()
	defer ut.mu.Unlock()

	err := ut.db.QueryRow(query,
		key).Scan(values)

	if err != nil {
		return fmt.Errorf("problem with selecting! %v", err)
	}

	return err
}

func (ut *usersTable) makeInsert(query string, values ...interface{}) error {
	ut.mu.Lock()
	defer ut.mu.Unlock()

	// Выполняем дефолтный инсерт в базу данных (вставка в таблицу)
	_, err := ut.db.Exec(query,
		values...)

	if err != nil {
		return fmt.Errorf("problem with inserting! %v", err)
	}

	return nil
}

func (ut *usersTable) makeUpdate(query string, key interface{}, values ...interface{}) error {
	ut.mu.Lock()
	defer ut.mu.Unlock()

	values = append(values, &key)

	_, err := ut.db.Exec(query,
		values...)

	if err != nil {
		fmt.Errorf("problem with updating! %v", err)
	}

	return nil
}

func (ut *usersTable) makeDelete(query string, key interface{}) error {
	ut.mu.Lock()
	defer ut.mu.Unlock()

	_, err := ut.db.Exec(query, key)

	if err != nil {
		return fmt.Errorf("problem with deleting! %v", err)
	}

	return nil
}

// дальше не эндпоинт, просто самая бесполезная функция

// связываем нашу абстракцию с единым подключением и мьютексом
func (ut *usersTable) new(db *sql.DB, mu *sync.Mutex) error {
	ut.db, ut.mu = db, mu

	_, err := db.Exec(`CREATE TABLE IF NOT EXISTS users (
				id SERIAL PRIMARY KEY,
				email VARCHAR(255) NOT NULL,
				password TEXT NOT NULL
		);
		`)
	return err
}
