package database

// TODO: =ПЕРЕПИШУ=

import (
	"encoding/json"
	"iqj/models"
)

func (st *Storage) createTeacher(teacher *models.Teacher) error {
	jsongroups, err := json.Marshal(teacher.Groups)
	if err != nil {
		return err
	}
	_, err = st.Db.Exec("INSERT INTO teachers (id, groups) VALUES ($1,$2)", teacher.Id, jsongroups)

	return err
}
