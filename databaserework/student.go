package databaserework

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/lib/pq"
)

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
	qm queryMaker
}

func (st *studentTable) Add(s *Student) error {

	// Проверяем были ли переданы данные в ud
	if s.isDefault() {
		return errors.New("Student.Add: wrong data! provided *Student is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := st.qm.makeInsert(st.db,
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
	student_values, err := st.qm.makeSelect(st.db,
		"SELECT StudentGroupId, StudentTeachersIds FROM Students WHERE StudentId = $1",
		s.Id)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Student.GetById: %v", err)
	}
	// TODO: исправить условие снизу
	if student_values.Next() {
		student_values.Scan(&s.Group, pq.Array(&s.Teachers))
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
	classes, err := st.qm.makeSelect(st.db,
		`SELECT s.*
											FROM schedule s
											JOIN student_groups sg ON s.group_id = ANY(sg.students)
											WHERE $1 = ANY(sg.students);
											`, s.Id)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Student.GetRoleById: %v", err)
	}

	var resultClasses []Class
	var resultClass Class

	for classes.Next() {
		classes.Scan(&resultClass.Id, pq.Array(&resultClass.Groups), &resultClass.Teacher, &resultClass.Count, &resultClass.Weekday, &resultClass.Week, &resultClass.Name, &resultClass.Type, &resultClass.Location)
		resultClasses = append(resultClasses, resultClass)
	}

	return &resultClasses, nil
}

// Возвращает пользователя(массив из одного элемента) из базы данных
func (st *studentTable) GetClassesByCurrentDay(s *Student, wc, wd int) (*[]Class, error) {

	// Проверяем переданы ли данные в функцию
	if s.isDefault() {
		return nil, errors.New("Student.GetClassesByWeekday: wrong data! provided *Student is empty")
	}
	// Проверяем передан ли id
	if s.Id == 0 {
		return nil, errors.New("Student.GetClassesByWeekday: wrong data! provided *Student.Id is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	classes, err := st.qm.makeSelect(st.db, // TODO: Оптимизировать запрос
		`SELECT s.*
			FROM schedule s
			JOIN student_groups sg ON s.group_id = ANY(sg.students)
			JOIN students st ON sg.id = st.student_group
			WHERE st.id = $1 AND s.weekday = $2 AND s.Week = $3"`,
		s.Id, wd, wc)

	// Проверяем ошибку select'а
	if err != nil {
		return nil, fmt.Errorf("Student.GetRoleById: %v", err)
	}

	var resultClasses []Class
	var resultClass Class

	for classes.Next() {
		classes.Scan(&resultClass.Id, pq.Array(&resultClass.Groups), &resultClass.Teacher, &resultClass.Count, &resultClass.Weekday, &resultClass.Week, &resultClass.Name, &resultClass.Type, &resultClass.Location)
		resultClasses = append(resultClasses, resultClass)
	}

	return &resultClasses, nil
}

func (st *studentTable) Delete(s *Student) error {
	//  Проверяем дали ли нам нужные данные
	if s.isDefault() {
		return errors.New("Student.Delete: wrong data! *UserData.Id is empty")
	}

	// Для удаления используем базовую функцию
	err := st.qm.makeDelete(st.db, "DELETE FROM users_data WHERE id = $1", s.Id)

	if err != nil {
		return fmt.Errorf("Student.Delete: %v", err)
	}

	return nil
}
