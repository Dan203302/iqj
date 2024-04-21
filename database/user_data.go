package databaserework

import (
	"database/sql"
	"errors"
	"fmt"
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
type userDataTable struct {
	// Указатель на подключение к базе данных
	db *sql.DB
	// Единый мьютекс, используемый при подключении к базе данных
	// mu *sync.Mutex
	tm transactionMaker
}

func (udt *userDataTable) Add(ud *UserData) error {

	// Проверяем были ли переданы данные в ud
	if ud.isDefault() {
		return errors.New("UserData.Add: wrong data! provided *UserData is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := udt.tm.makeInsert(udt.db,
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

	rows, err := udt.tm.makeSelect(udt.db,
		"SELECT Name, Bio, UsefulData, Role FROM UsersData WHERE UserDataId = $1",
		ud.Id)
	if err != nil {
		return nil, fmt.Errorf("UserData.GetById: %v", err)
	}
	defer rows.Close()
	// TODO: исправить условие снизу
	if rows.Next() {
		if err := rows.Scan(&ud.Name, &ud.Bio, &ud.UsefulData, &ud.Role); err != nil {
			return nil, err
		}
	} else {
		return nil, errors.New("UserData.GetById: no rows returned")
	}

	return ud, nil
}

// Возвращает данные пользователя из базы данных по имени
func (udt *userDataTable) GetByName(ud *UserData) (*UserData, error) {
	// Проверяем переданы ли данные в функцию
	// if ud.isDefault() {
	// 	return nil, errors.New("UserData.GetByName: wrong data! provided *UserData is empty")
	// }
	// Проверяем передано ли имя пользователя
	if ud.Name == "" {
		return nil, errors.New("UserData.GetByName: wrong data! provided *UserData.Name is empty")
	}

	rows, err := udt.tm.makeSelect(udt.db,
		"SELECT UserDataId, Bio, UsefulData, Role FROM UsersData WHERE UserName = $1",
		ud.Name)
	if err != nil {
		return nil, fmt.Errorf("UserData.GetByName: %v", err)
	}
	defer rows.Close()
	// TODO: исправить условие снизу
	if rows.Next() {
		if err := rows.Scan(&ud.Id, &ud.Bio, &ud.UsefulData, &ud.Role); err != nil {
			return nil, err
		}
	} else {
		return nil, errors.New("UserData.GetByName: no rows returned")
	}

	return ud, nil
}

// Возвращает пользователя(массив из одного элемента) из базы данных
func (udt *userDataTable) GetRoleById(ud *UserData) (*UserData, error) {
	// Проверяем переданы ли данные в функцию
	// if ud.isDefault() {
	// 	return nil, errors.New("UsersData.GetRoleById: wrong data! provided *UserData is empty")
	// }
	// Проверяем передан ли id
	if ud.Id == 0 {
		return nil, errors.New("UserData.GetRoleById: wrong data! provided *UserData.Id is empty")
	}

	rows, err := udt.tm.makeSelect(udt.db,
		"SELECT Role FROM UsersData WHERE UserDataId = $1",
		ud.Id)
	if err != nil {
		return nil, fmt.Errorf("UserData.GetRoleById: %v", err)
	}
	defer rows.Close()
	// TODO: исправить условие снизу
	if rows.Next() {
		if err := rows.Scan(&ud.Role); err != nil {
			return nil, err
		}
	} else {
		return nil, errors.New("UserData.GetRoleById: no rows returned")
	}

	return ud, nil
}

func (udt *userDataTable) Delete(ud *UserData) error {
	//  Проверяем дали ли нам нужные данные
	// if ud.isDefault() {
	// 	return errors.New("UsersData.Delete: wrong data! *UserData.Id is empty")
	// }

	if ud.Id == 0 {
		return errors.New("UserData.Delete: wrong data! *UserData.Id is empty")
	}

	// Для удаления используем базовую функцию
	err := udt.tm.makeDelete(udt.db,
		"DELETE FROM UsersData WHERE UserDataId = $1",
		ud.Id)

	if err != nil {
		return fmt.Errorf("UserData.Delete: %v", err)
	}

	return nil
}
