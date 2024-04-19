package databaserework

import (
	"database/sql"
	"errors"
	"fmt"
	"sync"
)

type UserData struct {
	Id         int    `json:"id"`
	Name       string `json:"name"`
	Bio        string `json:"bio"`
	UsefulData string `json:"useful_data"`
	Role       string `json:"role"`
}

/*
Проверяет, переданы ли какие-либо данные в структуру.
Необходимо для реализаци интерфейса Entity, а также для фильтров в функциях БД
*/
func (ud *UserData) isDefault() bool {
	return ud.Id == 0 || ud.Name == "" || ud.Bio == "" || ud.UsefulData == "" || ud.Role == ""
}

// Структура для более удобного и понятного взаимодействия с таблицой users_data
type usersDataTable struct {
	// Указатель на подключение к базе данных
	db *sql.DB
	// Единый мьютекс, используемый при подключении к базе данных
	mu *sync.Mutex
}

func (udt *usersDataTable) Add(ud *UserData) error {

	// Проверяем были ли переданы данные в ud
	if ud.isDefault() {
		return errors.New("UsersData.Add: wrong data! provided *UserData is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := udt.makeInsert(
		"INSERT INTO users_data (id,name,bio,useful_data,role) VALUES ($1, $2, $3, $4, $5)",
		&ud.Id, &ud.Name, &ud.Bio, &ud.UsefulData, &ud.Role,
	)

	if err != nil {
		return fmt.Errorf("UsersData.Add: %v", err)
	}

	return nil
}

// Возвращает данные пользователя из базы данных по ID
func (udt *usersDataTable) GetById(ud *UserData) (*UserData, error) {

	// Проверяем переданы ли данные в функцию
	if ud.isDefault() {
		return nil, errors.New("UsersData.GetById: wrong data! provided *UserData is empty")
	}
	// Проверяем передан ли id
	if ud.Id == 0 {
		return nil, errors.New("UsersData.GetById: wrong data! provided *UserData.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := udt.makeSelect("SELECT name, bio, useful_data, role FROM users_data WHERE id = $1",
		ud.Id, &ud.Name, &ud.Bio, &ud.UsefulData, &ud.Role)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("UsersData.GetById: %v", err)
	}
	return ud, nil
}

// Возвращает данные пользователя из базы данных по имени
func (udt *usersDataTable) GetByName(ud *UserData) (*UserData, error) {

	// Проверяем переданы ли данные в функцию
	if ud.isDefault() {
		return nil, errors.New("UsersData.GetByName: wrong data! provided *UserData is empty")
	}
	// Проверяем передан ли id
	if ud.Name == "" {
		return nil, errors.New("UsersData.GetByName: wrong data! provided *UserData.Name is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := udt.makeSelect("SELECT id, bio, useful_data, role FROM users_data WHERE name = $1",
		ud.Name, &ud.Id, &ud.Bio, &ud.UsefulData, &ud.Role)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("UsersData.GetByName: %v", err)
	}
	return ud, nil
}

// Возвращает пользователя(массив из одного элемента) из базы данных
func (udt *usersDataTable) GetRoleById(ud *UserData) (*UserData, error) {

	// Проверяем переданы ли данные в функцию
	if ud.isDefault() {
		return nil, errors.New("UsersData.GetRoleById: wrong data! provided *UserData is empty")
	}
	// Проверяем передан ли id
	if ud.Id == 0 {
		return nil, errors.New("UsersData.GetRoleById: wrong data! provided *UserData.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := udt.makeSelect("SELECT role FROM users_data WHERE id = $1",
		ud.Id, &ud.Role)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("UsersData.GetRoleById: %v", err)
	}
	return u, nil
}

func (udt *usersDataTable) Delete(ud *UserData) error {
	//  Проверяем дали ли нам нужные данные
	if ud.isDefault() {
		return errors.New("UsersData.Delete: wrong data! *UserData.Id is empty")
	}

	// Для удаления используем базовую функцию
	err := udt.makeDelete("DELETE FROM users_data WHERE id = $1", ud.Id)

	if err != nil {
		return fmt.Errorf("UsersData.Delete: %v", err)
	}

	return nil
}

// ====== ЭНДПОИНТЫ ======

func (udt *usersDataTable) makeSelectMultiple(query string, key interface{}) (*[]User, error) {
	udt.mu.Lock()
	defer udt.mu.Unlock()

	rows, err := udt.db.Query(query, key)
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

func (udt *usersDataTable) makeSelect(query string, key interface{}, values ...interface{}) error {
	udt.mu.Lock()
	defer udt.mu.Unlock()

	err := udt.db.QueryRow(query,
		key).Scan(values)

	if err != nil {
		return fmt.Errorf("problem with selecting! %v", err)
	}

	return err
}

func (udt *usersDataTable) makeInsert(query string, values ...interface{}) error {
	udt.mu.Lock()
	defer udt.mu.Unlock()

	// Выполняем дефолтный инсерт в базу данных (вставка в таблицу)
	_, err := udt.db.Exec(query,
		values...)

	if err != nil {
		return fmt.Errorf("problem with inserting! %v", err)
	}

	return nil
}

func (udt *usersDataTable) makeUpdate(query string, key interface{}, values ...interface{}) error {
	udt.mu.Lock()
	defer udt.mu.Unlock()

	values = append(values, &key)

	_, err := udt.db.Exec(query,
		values...)

	if err != nil {
		fmt.Errorf("problem with updating! %v", err)
	}

	return nil
}

func (udt *usersDataTable) makeDelete(query string, key interface{}) error {
	udt.mu.Lock()
	defer udt.mu.Unlock()

	_, err := udt.db.Exec(query, key)

	if err != nil {
		return fmt.Errorf("problem with deleting! %v", err)
	}

	return nil
}

// дальше не эндпоинт, просто самая бесполезная функция

// связываем нашу абстракцию с единым подключением и мьютексом
func (udt *usersDataTable) new(db *sql.DB, mu *sync.Mutex) error {
	udt.db, udt.mu = db, mu

	_, err := db.Exec(`CREATE TABLE IF NOT EXISTS users_data (
				id INT PRIMARY KEY,
				name VARCHAR(255) NOT NULL,
				bio TEXT NOT NULL,
				useful_data TEXT NOT NULL,
				role VARCHAR(50) NOT NULL
		);
		`)

	if err != nil {
		return fmt.Errorf("Database.UsersData.new: problem with creating table: %v", err)
	}
	return nil
}
