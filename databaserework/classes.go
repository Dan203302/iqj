package databaserework

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/lib/pq"
)

type Class struct {
	Id       int
	Groups   []int
	Teacher  int
	Count    int
	Weekday  int
	Week     int
	Name     string
	Type     string
	Location string
}

func (c *Class) isDefault() bool {
	return c.Id == 0 || c.Groups == nil || c.Teacher == 0 || c.Count == 0 || c.Weekday == 0 || c.Week == 0 || c.Name == "" || c.Type == "" || c.Location == ""
}

type classTable struct {
	db *sql.DB
	qm queryMaker
}

func (ct *classTable) Add(c *Class) error {
	if c.isDefault() {
		return errors.New("Class.Add: wrong data! provided *Class is empty")
	}

	err := ct.qm.makeInsert(ct.db,
		`INSERT INTO Classes (ClassGroupIds, ClassTeacherId, Count, Weekday, Week, ClassName, ClassType, ClassLocation)
		SELECT $1, $2, $3, $4, $5, $6, $7, $8
		WHERE NOT EXISTS (
    	SELECT 1 FROM Classes
     	WHERE ClassName = $6
    	AND Weekday = $4
        AND Week = $5
        AND ClassType = $7
        AND Count = $3
        AND ClassGroupId = $1
        AND ClassTeacherId = $2
)`,
		pq.Array(&c.Groups), &c.Teacher, &c.Count, &c.Weekday, &c.Week, &c.Name, &c.Type, &c.Location)

	if err != nil {
		return fmt.Errorf("Class.Add: %v", err)
	}

	return nil
}

func (ct *classTable) GetById() {}

func (ct *classTable) GetByTeacher() {}
