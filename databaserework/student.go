package databaserework

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/lib/pq"
)

// ====== ТРАНЗАКЦИИ В КОНЦЕ ФАЙЛА ======

type Student struct {
	Id       int   `json:"id"`
	Group    int   `json:"group"`
	Teachers []int `json:"teachers"`
}

/*
Проверяет, переданы ли какие-либо данные в структуру.
Необходимо для реализаци интерфейса Entity, а также для фильтров в функциях БД
*/
func (s *Student) isDefault() bool {
	return s.Id == 0 || s.Group == 0 || s.Teachers == nil
}

// Структура для более удобного и понятного взаимодействия с таблицой students
type studentTable struct {
	// Указатель на подключение к базе данных
	db *sql.DB
	// Единый мьютекс, используемый при подключении к базе данных
	// mu *sync.Mutex
}

func (st *studentTable) Add(s *Student) error {

	// Проверяем были ли переданы данные в ud
	if s.isDefault() {
		return errors.New("Student.Add: wrong data! provided *Student is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := st.makeInsert(
		"INSERT INTO Students (StudentId,StudentGroupId,StudentTeachersIds) VALUES ($1, $2, $3, $4, $5)",
		&s.Id, &s.Group, pq.Array(&s.Teachers),
	)

	if err != nil {
		return fmt.Errorf("Student.Add: %v", err)
	}

	return nil
}

// Возвращает данные пользователя из базы данных по ID
func (st *studentTable) GetById(s *Student) (*Student, error) {

	// Проверяем переданы ли данные в функцию
	if s.isDefault() {
		return nil, errors.New("Student.GetById: wrong data! provided *Student is empty")
	}
	// Проверяем передан ли id
	if s.Id == 0 {
		return nil, errors.New("Student.GetById: wrong data! provided *Student.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	err := st.makeSelect("SELECT StudentGroupId, StudentTeachersIds FROM Students WHERE StudentId = $1",
		s.Id, &s.Group, pq.Array(&s.Teachers))

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Student.GetById: %v", err)
	}
	return s, nil
}

// Возвращает пользователя(массив из одного элемента) из базы данных
func (st *studentTable) GetClasses(s *Student) (*[]Class, error) {

	// Проверяем переданы ли данные в функцию
	if s.isDefault() {
		return nil, errors.New("Student.GetClasses: wrong data! provided *Student is empty")
	}
	// Проверяем передан ли id
	if s.Id == 0 {
		return nil, errors.New("Student.GetClasses: wrong data! provided *Student.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	classes, err := st.makeSelectMultiple(`SELECT s.*
											FROM schedule s
											JOIN student_groups sg ON s.group_id = ANY(sg.students)
											WHERE $1 = ANY(sg.students);
											`, s.Id)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Student.GetRoleById: %v", err)
	}
	return classes, nil
}

// Возвращает пользователя(массив из одного элемента) из базы данных
func (st *studentTable) GetClassesByWeekday(s *Student, wd int) (*[]Class, error) {

	// Проверяем переданы ли данные в функцию
	if s.isDefault() {
		return nil, errors.New("Student.GetClassesByWeekday: wrong data! provided *Student is empty")
	}
	// Проверяем передан ли id
	if s.Id == 0 {
		return nil, errors.New("Student.GetClassesByWeekday: wrong data! provided *Student.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	classes, err := st.makeSelectMultiple(`SELECT s.*
											FROM schedule s
											JOIN student_groups sg ON s.group_id = ANY(sg.students)
											JOIN students st ON sg.id = st.student_group
											WHERE st.id = $1 AND s.weekday = $2"`,
		s.Id, wd)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Student.GetRoleById: %v", err)
	}
	return classes, nil
}

func (st *studentTable) Delete(s *Student) error {
	//  Проверяем дали ли нам нужные данные
	if s.isDefault() {
		return errors.New("Student.Delete: wrong data! *UserData.Id is empty")
	}

	// Для удаления используем базовую функцию
	err := st.makeDelete("DELETE FROM users_data WHERE id = $1", s.Id)

	if err != nil {
		return fmt.Errorf("Student.Delete: %v", err)
	}

	return nil
}

// ====== ТРАНЗАКЦИИ ======

func (st *studentTable) makeSelectMultiple(query string, key ...interface{}) (*[]Class, error) {

	rows, err := st.db.Query(query, key...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var classes []Class
	for rows.Next() {
		var class Class
		if err := rows.Scan(&class.Id, &class.Groups, &class.Teacher, &class.Count, &class.Weekday, &class.Week, &class.Name, &class.Type, &class.Location); err != nil {
			return nil, err
		}
		classes = append(classes, class)
	}
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("problem with selecting multiple values! %v", err)
	}

	return &classes, nil
}

func (st *studentTable) makeSelect(query string, key interface{}, values ...interface{}) error {

	err := st.db.QueryRow(query,
		key).Scan(values)

	if err != nil {
		return fmt.Errorf("problem with selecting! %v", err)
	}

	return err
}

func (st *studentTable) makeInsert(query string, values ...interface{}) error {

	// Выполняем дефолтный инсерт в базу данных (вставка в таблицу)
	_, err := st.db.Exec(query,
		values...)

	if err != nil {
		return fmt.Errorf("problem with inserting! %v", err)
	}

	return nil
}

func (st *studentTable) makeUpdate(query string, key interface{}, values ...interface{}) error {

	values = append(values, &key)

	_, err := st.db.Exec(query,
		values...)

	if err != nil {
		return fmt.Errorf("problem with updating! %v", err)
	}

	return nil
}

func (st *studentTable) makeDelete(query string, key interface{}) error {
	tx, err := st.db.Begin()
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
