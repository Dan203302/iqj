package database

// TODO: =ПЕРЕПИШУ=

import (
	"encoding/json"
	"iqj/models"
)

func (st *Storage) createStudent(student *models.Student) error {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	jsonTeachers, err := json.Marshal(student.Teachers)
	if err != nil {
		return err
	}

	_, err = st.Db.Exec("INSERT INTO students (id,student_group,teachers) values ($1,$2,$3)",
		student.Id, student.Group, jsonTeachers)

	return err
}

func (st *Storage) addTeachers(student *models.Student, teachers *[]models.Teacher) error {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	jsonTeachers, err := json.Marshal(teachers)
	if err != nil {
		return err
	}

	_, err = st.Db.Exec("INSERT INTO students (teachers) values ($1)",
		student.Id, student.Group, jsonTeachers)

	return err

}
