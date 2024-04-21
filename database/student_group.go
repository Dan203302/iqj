package database

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/lib/pq"
)

// StudentGroup представляет сущность группы студентов в системе.
type StudentGroup struct {
	Id        int    // Уникальный идентификатор группы
	Grade     int    // Курс группы
	Institute string // Название института
	Name      string // Название группы
	Students  []int  // Идентификаторы студентов в группе
}

// isDefault проверяет, переданы ли какие-либо данные в структуру StudentGroup.
// Необходимо для реализации интерфейса Entity и фильтров в функциях БД.
func (sg *StudentGroup) isDefault() bool {
	return sg.Id == 0 || sg.Grade == 0 || sg.Institute == "" || sg.Name == "" || sg.Students == nil
}

// StudentGroupTable предоставляет методы для работы с таблицей групп студентов в базе данных.
type StudentGroupTable struct {
	db *sql.DB    // Указатель на подключение к базе данных
	qm queryMaker // Исполнитель ОБЫЧНЫХ sql запросов
}

// GetByID возвращает группу студентов из базы данных по указанному идентификатору.
// Принимает указатель на StudentGroup с заполненным полем Id.
// Возвращает заполненную структуру StudentGroup и nil при успешном запросе.
//
// Прим:
// sg := &StudentGroup{Id: 1}
// group, err := ...GetByID(sg) // err == nil если все хорошо
func (sgt *StudentGroupTable) GetByID(sg *StudentGroup) (*StudentGroup, error) {
	if sg.isDefault() {
		return nil, errors.New("StudentGroup.GetByID: wrong data! provided *StudentGroup is empty!")
	}

	row, err := sgt.qm.makeSelect(sgt.db,
		"SELECT Grade, Institute, StudentGroupName, StudentGroupStudentsIds FROM StudentsGroups WHERE StudentsGroupId = $1",
		sg.Id)
	if err != nil {
		return nil, fmt.Errorf("studentGroupTable.GetByID: %v", err)
	}
	defer row.Close()

	if row.Next() {
		if err := row.Scan(&sg.Grade, &sg.Institute, &sg.Name, pq.Array(&sg.Students)); err != nil {
			return nil, fmt.Errorf("studentGroupTable.GetByID: %v", err)
		}
	} else {
		return nil, errors.New("studentGroupTable.GetByID: no rows returned")
	}

	return sg, nil
}

// GetStudent возвращает группу студентов из базы данных по указанному идентификатору студента.
// Принимает указатель на StudentGroup с заполненным полем Id.
// Возвращает заполненную структуру StudentGroup и nil при успешном запросе.
//
// Прим:
// sg := &StudentGroup{Id: 1}
// group, err := ...GetStudent(sg) // err == nil если все хорошо
func (sgt *StudentGroupTable) GetStudent(sg *StudentGroup) (*StudentGroup, error) {
	if sg.isDefault() {
		return nil, errors.New("StudentGroup.GetStudent: wrong data! provided *StudentGroup is empty!")
	}

	row, err := sgt.qm.makeSelect(sgt.db,
		"SELECT sg.Grade, sg.Institute, sg.StudentGroupName, sg.StudentGroupStudentsIds FROM StudentsGroups sg JOIN Students s ON sg.StudentsGroupId = s.StudentGroupId WHERE s.StudentId = $1",
		sg.Id)
	if err != nil {
		return nil, fmt.Errorf("studentGroupTable.GetStudent: %v", err)
	}
	defer row.Close()

	if row.Next() {
		if err := row.Scan(&sg.Grade, &sg.Institute, &sg.Name, pq.Array(&sg.Students)); err != nil {
			return nil, fmt.Errorf("studentGroupTable.GetStudent: %v", err)
		}
	} else {
		return nil, errors.New("studentGroupTable.GetStudent: no rows returned")
	}

	return sg, nil
}

// GetGroupsByInstituteAndGrade возвращает группы студентов из базы данных по названию института и курсу.
// Принимает название института и номер курса.
// Возвращает срез указателей на структуры StudentGroup и nil при успешном запросе.
//
// Прим:
// groups, err := ...GetGroupsByInstituteAndGrade("Институт", 3) // Получить группы для 3 курса в институте
func (sgt *StudentGroupTable) GetGroupsByInstituteAndGrade(institute string, grade int) ([]*StudentGroup, error) {
	groups := []*StudentGroup{}

	rows, err := sgt.qm.makeSelect(sgt.db,
		"SELECT StudentsGroupId, StudentGroupName, StudentGroupStudentsIds FROM StudentsGroups WHERE Institute = $1 AND Grade = $2",
		institute, grade)
	if err != nil {
		return nil, fmt.Errorf("studentGroupTable.GetGroupsByInstituteAndGrade: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		group := &StudentGroup{}
		if err := rows.Scan(&group.Id, &group.Name, pq.Array(&group.Students)); err != nil {
			return nil, fmt.Errorf("studentGroupTable.GetGroupsByInstituteAndGrade: %v", err)
		}
		groups = append(groups, group)
	}

	return groups, nil
}

// GetGroupsByInstitute возвращает группы студентов из базы данных по названию института.
// Принимает указатель на структуру StudentGroup с заполненным полем Institute.
// Возвращает срез указателей на структуры StudentGroup и nil при успешном запросе.
//
// Прим:
// sg := &StudentGroup{Institute: "Институт"}
// groups, err := ...GetGroupsByInstitute(sg) // Получить группы в институте
func (sgt *StudentGroupTable) GetGroupsByInstitute(sg *StudentGroup) ([]*StudentGroup, error) {
	groups := []*StudentGroup{}

	rows, err := sgt.qm.makeSelect(sgt.db,
		"SELECT StudentsGroupId, StudentGroupName, StudentGroupStudentsIds FROM StudentsGroups WHERE Institute = $1",
		sg.Institute)
	if err != nil {
		return nil, fmt.Errorf("studentGroupTable.GetGroupsByInstitute: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		group := &StudentGroup{}
		if err := rows.Scan(&group.Id, &group.Name, pq.Array(&group.Students)); err != nil {
			return nil, fmt.Errorf("studentGroupTable.GetGroupsByInstitute: %v", err)
		}
		groups = append(groups, group)
	}

	return groups, nil
}

// GetGroupsByGrade возвращает группы студентов из базы данных по номеру курса.
// Принимает указатель на структуру StudentGroup с заполненным полем Grade.
// Возвращает срез указателей на структуры StudentGroup и nil при успешном запросе.
//
// Прим:
// sg := &StudentGroup{Grade: 3}
// groups, err := ...GetGroupsByGrade(sg) // Получить группы на 3 курсе
func (sgt *StudentGroupTable) GetGroupsByGrade(sg *StudentGroup) ([]*StudentGroup, error) {
	groups := []*StudentGroup{}

	rows, err := sgt.qm.makeSelect(sgt.db,
		"SELECT StudentsGroupId, StudentGroupName, StudentGroupStudentsIds FROM StudentsGroups WHERE Grade = $1",
		sg.Grade)
	if err != nil {
		return nil, fmt.Errorf("studentGroupTable.GetGroupsByGrade: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		group := &StudentGroup{}
		if err := rows.Scan(&group.Id, &group.Name, pq.Array(&group.Students)); err != nil {
			return nil, fmt.Errorf("studentGroupTable.GetGroupsByGrade: %v", err)
		}
		groups = append(groups, group)
	}

	return groups, nil
}

// Add добавляет группу студентов в базу данных.
// Принимает указатель на структуру StudentGroup с заполненными полями.
// Возвращает nil при успешном добавлении.
//
// Прим:
// group := &StudentGroup{Grade: 1, Institute: "Институт", Name: "Группа 1", Students: []int{1, 2, 3}}
// err := ...Add(group) // err == nil если все хорошо
func (sgt *StudentGroupTable) Add(group *StudentGroup) error {
	if group.isDefault() {
		return errors.New("studentGroupTable.Add: wrong data! provided *StudentGroup is empty")
	}

	err := sgt.qm.makeInsert(sgt.db,
		"INSERT INTO StudentsGroups (Grade, Institute, StudentGroupName, StudentGroupStudentsIds) VALUES ($1, $2, $3, $4)",
		&group.Grade, &group.Institute, &group.Name, pq.Array(&group.Students))
	if err != nil {
		return fmt.Errorf("studentGroupTable.Add: %v", err)
	}

	return nil
}

// Update обновляет данные о группе студентов в базе данных.
// Принимает указатель на структуру StudentGroup с заполненными полями.
// Возвращает nil при успешном обновлении.
//
// Прим:
// group := &StudentGroup{Id: 1, Grade: 2, Institute: "Институт", Name: "Группа 2", Students: []int{4, 5, 6}}
// err := ...Update(group) // err == nil если все хорошо
func (sgt *StudentGroupTable) Update(group *StudentGroup) error {
	if group.isDefault() {
		return errors.New("studentGroupTable.Update: wrong data! provided *StudentGroup is empty")
	}

	_, err := sgt.db.Exec("UPDATE StudentsGroups SET Grade = $1, Institute = $2, StudentGroupName = $3, StudentGroupStudentsIds = $4 WHERE StudentsGroupId = $5",
		group.Grade, group.Institute, group.Name, pq.Array(&group.Students), group.Id)
	if err != nil {
		return fmt.Errorf("studentGroupTable.Update: %v", err)
	}

	return nil
}

// Delete удаляет группу студентов из базы данных по указанному идентификатору.
// Принимает указатель на структуру StudentGroup с заполненным полем Id.
// Возвращает nil при успешном удалении.
//
// Прим:
// sg := &StudentGroup{Id: 1}
// err := ...Delete(sg) // err == nil если все хорошо
func (sgt *StudentGroupTable) Delete(sg *StudentGroup) error {
	_, err := sgt.db.Exec("DELETE FROM StudentsGroups WHERE StudentsGroupId = $1", sg.Id)
	if err != nil {
		return fmt.Errorf("studentGroupTable.Delete: %v", err)
	}

	return nil
}
