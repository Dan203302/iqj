package databaserework

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/lib/pq"
)

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
	qm queryMaker
}

func (tt *teacherTable) Add(t *Teacher) error {

	// Проверяем были ли переданы данные в t
	if t.isDefault() {
		return errors.New("Teachers.Add: wrong data! provided *Teacher is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := tt.qm.makeInsert(tt.db,
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
	row, err := tt.qm.makeSelect(tt.db,
		"SELECT groups FROM teachers WHERE id = $1",
		t.Id)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Teachers.GetById: %v", err)
	}

	// TODO: исправить условие снизу
	row.Scan(pq.Array(*&t.Groups))

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
	err := tt.qm.makeUpdate(tt.db,
		"UPDATE teachers SET groups = $1 WHERE id = $2",
		t.Id, &t.Groups)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Teachers.GetById: %v", err)
	}
	return t, nil
}
