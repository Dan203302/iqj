package databaserework

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/lib/pq"
)

// ====== ТРАНЗАКЦИИ В КОНЦЕ ФАЙЛА ======

type Teacher struct {
	Id     int   `json:"id"`
	Groups []int `json:"groups"`
}

/*
Проверяет, переданы ли какие-либо данные в структуру.
Необходимо для реализаци интерфейса Entity, а также для фильтров в функциях БД
*/
func (t *Teacher) isDefault() bool {
	return t.Id == 0 || t.Groups == nil
}

// Структура для более удобного и понятного взаимодействия с таблицой users_data
type teacherTable struct {
	// Указатель на подключение к базе данных
	db *sql.DB
	// Единый мьютекс, используемый при подключении к базе данных
	// mu *sync.Mutex
}

func (tt *teacherTable) Add(t *Teacher) error {

	// Проверяем были ли переданы данные в t
	if t.isDefault() {
		return errors.New("Teachers.Add: wrong data! provided *Teacher is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := tt.makeInsert(
		"INSERT INTO teachers (id,groups) VALUES ($1, $2)",
		&t.Id, &t.Groups,
	)

	if err != nil {
		return fmt.Errorf("Teachers.Add: %v", err)
	}

	return nil
}

// Возвращает данные пользователя из базы данных по ID
func (tt *teacherTable) GetById(t *Teacher) (*Teacher, error) {

	// Проверяем переданы ли данные в функцию
	if t.isDefault() {
		return nil, errors.New("Teachers.GetById: wrong data! provided *Teacher is empty")
	}
	// Проверяем передан ли id
	if t.Id == 0 {
		return nil, errors.New("Teachers.GetById: wrong data! provided *Teacher.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := tt.makeSelect("SELECT groups FROM teachers WHERE id = $1",
		t.Id, pq.Array(&t.Groups))

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Teachers.GetById: %v", err)
	}
	return t, nil
}

func (tt *teacherTable) UpdateGroups(t *Teacher) (*Teacher, error) {
	// Проверяем переданы ли данные в функцию
	if t.isDefault() {
		return nil, errors.New("Teachers.UpdateGroups: wrong data! provided *Teacher is empty")
	}
	// Проверяем передан ли id
	if t.Id == 0 {
		return nil, errors.New("Teachers.UpdateGroups: wrong data! provided *Teacher.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := tt.makeUpdate("UPDATE teachers SET groups = $1 WHERE id = $2",
		t.Id, &t.Groups)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Teachers.GetById: %v", err)
	}
	return t, nil
}

// ====== ТРАНЗАКЦИИ ======  на самом деле я посчитал что здесь они будут излишними, тут обычные запросы хаха

func (tt *teacherTable) makeSelect(query string, key interface{}, values ...interface{}) error {

	err := tt.db.QueryRow(query,
		key).Scan(values)

	if err != nil {
		return fmt.Errorf("problem with selecting! %v", err)
	}

	return err
}

func (tt *teacherTable) makeInsert(query string, values ...interface{}) error {

	// Выполняем дефолтный инсерт в базу данных (вставка в таблицу)
	_, err := tt.db.Exec(query,
		values...)

	if err != nil {
		return fmt.Errorf("problem with inserting! %v", err)
	}

	return nil
}

func (tt *teacherTable) makeUpdate(query string, key interface{}, values ...interface{}) error {

	values = append(values, &key)

	_, err := tt.db.Exec(query,
		values...)

	if err != nil {
		return fmt.Errorf("problem with updating! %v", err)
	}

	return nil
}
