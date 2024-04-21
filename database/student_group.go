package databaserework

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/lib/pq"
)

type StudentGroup struct {
	Id        int
	Grade     int
	Institute string
	Name      string
	Students  []int
}

func (sg *StudentGroup) isDefault() bool {
	return sg.Id == 0 || sg.Grade == 0 || sg.Institute == "" || sg.Name == "" || sg.Students == nil
}

type studentGroupTable struct {
	db *sql.DB
	qm queryMaker
}

func (sgt *studentGroupTable) GetByID(sg *StudentGroup) (*StudentGroup, error) {
	if sg.isDefault() {
		return nil, errors.New("StudentGroup.GetById: wrong data! provided *StudentGroup is empty!")
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

func (sgt *studentGroupTable) GetStudent(sg *StudentGroup) (*StudentGroup, error) {
	if sg.isDefault() {
		return nil, errors.New("StudentGroup.GetStudent: wrong data! provided *StudentGroup is empty!")
	}

	row, err := sgt.qm.makeSelect(sgt.db,
		"SELECT sg.Grade, sg.Institute, sg.StudentGroupName, sg.StudentGroupStudentsIds FROM StudentsGroups sg JOIN Students s ON sg.StudentsGroupId = s.StudentGroupId WHERE s.StudentId = $1",
		sg.Id)
	if err != nil {
		return nil, fmt.Errorf("studentGroupTable.GetStudentByID: %v", err)
	}
	defer row.Close()

	if row.Next() {
		if err := row.Scan(&sg.Grade, &sg.Institute, &sg.Name, pq.Array(&sg.Students)); err != nil {
			return nil, fmt.Errorf("studentGroupTable.GetStudenD: %v", err)
		}
	} else {
		return nil, errors.New("studentGroupTable.GetStudentByID: no rows returned")
	}

	return sg, nil
}

func (sgt *studentGroupTable) GetGroupsByInstituteAndGrade(institute string, grade int) ([]*StudentGroup, error) {
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

func (sgt *studentGroupTable) GetGroupsByInstitute(sg *StudentGroup) ([]*StudentGroup, error) {
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

func (sgt *studentGroupTable) GetGroupsByGrade(sg *StudentGroup) ([]*StudentGroup, error) {
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

func (sgt *studentGroupTable) Add(group *StudentGroup) error {
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

func (sgt *studentGroupTable) Update(group *StudentGroup) error {
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

func (sgt *studentGroupTable) Delete(sg *StudentGroup) error {
	_, err := sgt.db.Exec("DELETE FROM StudentsGroups WHERE StudentsGroupId = $1", sg.Id)
	if err != nil {
		return fmt.Errorf("studentGroupTable.Delete: %v", err)
	}

	return nil
}
