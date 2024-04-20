package databaserework

import (
	"database/sql"
	"errors"
	"fmt"
)

// ====== ТРАНЗАКЦИИ В КОНЦЕ ФАЙЛА ======

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
type userDataTable struct {
	// Указатель на подключение к базе данных
	db *sql.DB
	// Единый мьютекс, используемый при подключении к базе данных
	// mu *sync.Mutex
}

func (udt *userDataTable) Add(ud *UserData) error {

	// Проверяем были ли переданы данные в ud
	if ud.isDefault() {
		return errors.New("UserData.Add: wrong data! provided *UserData is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := udt.makeInsert(
		"INSERT INTO UsersData (UserDataId,UserName,Biography,UsefulData,Role) VALUES ($1, $2, $3, $4, $5)",
		&ud.Id, &ud.Name, &ud.Bio, &ud.UsefulData, &ud.Role,
	)

	if err != nil {
		return fmt.Errorf("UserData.Add: %v", err)
	}

	return nil
}

// Возвращает данные пользователя из базы данных по ID
func (udt *userDataTable) GetById(ud *UserData) (*UserData, error) {

	// Проверяем переданы ли данные в функцию
	if ud.isDefault() {
		return nil, errors.New("UserData.GetById: wrong data! provided *UserData is empty")
	}
	// Проверяем передан ли id
	if ud.Id == 0 {
		return nil, errors.New("UserData.GetById: wrong data! provided *UserData.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := udt.makeSelect("SELECT Name, Bio, UsefulData, Role FROM UsersData WHERE UserDataId = $1",
		ud.Id, &ud.Name, &ud.Bio, &ud.UsefulData, &ud.Role)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("UserData.GetById: %v", err)
	}
	return ud, nil
}

// Возвращает данные пользователя из базы данных по имени
func (udt *userDataTable) GetByName(ud *UserData) (*UserData, error) {

	// Проверяем переданы ли данные в функцию
	if ud.isDefault() {
		return nil, errors.New("UserData.GetByName: wrong data! provided *UserData is empty")
	}
	// Проверяем передан ли id
	if ud.Name == "" {
		return nil, errors.New("UserData.GetByName: wrong data! provided *UserData.Name is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := udt.makeSelect("SELECT UserDataId, Biography, UsefulData, Role FROM UsersData WHERE UserName = $1",
		ud.Name, &ud.Id, &ud.Bio, &ud.UsefulData, &ud.Role)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("UserData.GetByName: %v", err)
	}
	return ud, nil
}

// Возвращает пользователя(массив из одного элемента) из базы данных
func (udt *userDataTable) GetRoleById(ud *UserData) (*UserData, error) {

	// Проверяем переданы ли данные в функцию
	if ud.isDefault() {
		return nil, errors.New("UsersData.GetRoleById: wrong data! provided *UserData is empty")
	}
	// Проверяем передан ли id
	if ud.Id == 0 {
		return nil, errors.New("UsersData.GetRoleById: wrong data! provided *UserData.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := udt.makeSelect("SELECT Role FROM UsersData WHERE UserDataId = $1",
		ud.Id, &ud.Role)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("UsersData.GetRoleById: %v", err)
	}
	return ud, nil
}

func (udt *userDataTable) Delete(ud *UserData) error {
	//  Проверяем дали ли нам нужные данные
	if ud.isDefault() {
		return errors.New("UsersData.Delete: wrong data! *UserData.Id is empty")
	}

	// Для удаления используем базовую функцию
	err := udt.makeDelete("DELETE FROM UsersData WHERE UserDataId = $1", ud.Id)

	if err != nil {
		return fmt.Errorf("UsersData.Delete: %v", err)
	}

	return nil
}

// ====== ТРАНЗАКЦИИ ======

func (udt *userDataTable) makeSelectMultiple(query string, key interface{}) (*[]UserData, error) {

	rows, err := udt.db.Query(query, key)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var usersdata []UserData
	for rows.Next() {
		var userdata UserData
		if err := rows.Scan(&userdata.Name, &userdata.Bio, &userdata.UsefulData, &userdata.Role); err != nil {
			return nil, err
		}
		usersdata = append(usersdata, userdata)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("problem with selecting multiple values! %v", err)
	}

	return &usersdata, nil
}

func (udt *userDataTable) makeSelect(query string, key interface{}, values ...interface{}) error {

	err := udt.db.QueryRow(query,
		key).Scan(values)

	if err != nil {
		return fmt.Errorf("problem with selecting! %v", err)
	}

	return err
}

func (udt *userDataTable) makeInsert(query string, values ...interface{}) error {
	tx, err := udt.db.Begin()
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

func (udt *userDataTable) makeUpdate(query string, key interface{}, values ...interface{}) error {
	tx, err := udt.db.Begin()
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

func (udt *userDataTable) makeDelete(query string, key interface{}) error {
	tx, err := udt.db.Begin()
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
