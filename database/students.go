package database

// TODO: =ПЕРЕПИШУ=

import (
	"encoding/json"
	"iqj/models"
)

func (st *Storage) createStudent(student *models.Student) error {
	jsonteachers, err := json.Marshal(student.Teachers)
	if err != nil {
		return err
	}
	_, err = st.Db.Exec("INSERT INTO students (id,student_group,teachers) values ($1,$2,$3)", student.Id, student.Group, jsonteachers)

	return err
}

func (st *Storage) addTeachers(ids []int) error {
	// ...
	return nil
}
