package database

// TODO: =ПЕРЕПИШУ=
import (
	"encoding/json"
	"iqj/models"
)

func (st *Storage) addStudentsGroup(group *models.StudentGroup) error {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	jsonstudents, err := json.Marshal(group.StudentIDs)
	if err != nil {
		return err
	}

	_, err = st.Db.Exec(
		"INSERT INTO student_groups (id, grade, institute, name, students) VALUES ($1,$2,$3,$4,$5)",
		group.Id, group.Grade, group.Institute, group.Name, jsonstudents)

	return nil
}

func (st *Storage) getGroupByGroupID(id *int) (*models.StudentGroup, error) {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	group := models.StudentGroup{}
	var studentsJSON []byte

	err := st.Db.QueryRow(
		"SELECT grade, institute, name, students FROM student_groups WHERE id = $1",
		id).
		Scan(&group.Id, &group.Grade, &group.Institute, &group.Name, &studentsJSON)

	if err != nil {
		return nil, err
	}
	group.Id = *id

	if err := json.Unmarshal(studentsJSON, &group.StudentIDs); err != nil {
		return nil, err
	}

	return &group, nil
}
