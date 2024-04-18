/*
lol
*/
package databaserework

import (
	"database/sql"
	"fmt"
	"sync"
)

/*
====== ФИЛЬТРЫ НАХОДЯТСЯ В КОНЦЕ ФАЙЛА
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

// Структура для более удобного и понятного взаимодействия с таблицой users,
type usersTable struct {
	db *sql.DB
	mu *sync.Mutex
}

func (ut *usersTable) Add(u *User) error {

	// Проверяем были ли переданы данные в u
	if !u.isDefault() {
		return fmt.Errorf("wrong data: provided *User is empty")
	}

	// Закрываем мьютекс для того, чтобы не было проблем с конкуретностью, надеюсь
	// когда нибудь перейдем на транзакции, но, как по мне, это слишком много
	// работы для бесплатного проекта
	ut.mu.Lock()
	defer ut.mu.Unlock()

	// Выполняем дефолтный инсерт в базу данных (вставка в таблицу)
	_, err := ut.db.Exec(
		"INSERT INTO users (email,password) VALUES ($1, $2)",
		u.Email, u.Password)

	// если постгрес криво базарит
	if err != nil {
		return err
	}

	return nil
}

func (ut *usersTable) Get(u *User) ([]*User, error) {
	if !u.isDefault() {
		return nil, fmt.Errorf("wrong data: provided *User is empty")
	}

	err := ut.db.QueryRow("SELECT * FROM users WHERE id = $1",
		u.Id).Scan(&u.Id, &u.Email, &u.Password)

	if err != nil {
		return nil, err
	}

	result := []*User{u}

	return result, nil

}

// связываем нашу абстракцию с единым подключением и мьютексом
func (ut *usersTable) new(db *sql.DB, mu *sync.Mutex) {
	ut.db, ut.mu = db, mu
}
