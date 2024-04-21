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

func (ct *classTable) GetById(c *Class) (*Class, error) {
	if c.isDefault() {
		return nil, errors.New("Class.GetById: wrong data! provided *Class is empty")
	}

	row, err := ct.qm.makeSelect(ct.db,
		`SELECT ClassGroupIds, ClassTeacherId, Count, Weekday, Week, ClassName, ClassType, ClassLocation
FROM Classes
WHERE ClassId = $1;
`,
		c.Id)
	if err != nil {
		return nil, fmt.Errorf("Class.GetById: %v", err)
	}

	if !row.Next() {
		return nil, err // todo: написать ошибку
	}
	row.Scan(pq.Array(&c.Groups), &c.Teacher, &c.Count, &c.Weekday, &c.Week, &c.Name, &c.Type, &c.Location)

	return c, err

}

func (ct *classTable) GetForWeekByTeacher(c *Class) (*[]Class, error) {
	if c.isDefault() {
		return nil, errors.New("Class.GetById: wrong data! provided *Class is empty")
	}

	rows, err := ct.qm.makeSelect(ct.db,
		`SELECT ClassId, ClassGroupIds, Count, Weekday, ClassName, ClassType, ClassLocation
		FROM Classes
		WHERE ClassTeacherId = $1 AND Week = $2;`,
		c.Id, c.Week)
	if err != nil {
		return nil, fmt.Errorf("Class.GetById: %v", err)
	}

	var resultClasses []Class
	var resultClass Class

	for rows.Next() {
		rows.Scan(&resultClass.Id, pq.Array(&resultClass.Groups), &resultClass.Count, &resultClass.Weekday, &resultClass.Name, &resultClass.Type, &resultClass.Location)
		resultClass.Teacher, resultClass.Week = c.Teacher, c.Week
		resultClasses = append(resultClasses, resultClass)
	}

	return &resultClasses, nil
}

func (ct *classTable) GetForDayByTeacher(c *Class) (*[]Class, error) {
	if c.isDefault() {
		return nil, errors.New("Class.GetById: wrong data! provided *Class is empty")
	}

	rows, err := ct.qm.makeSelect(ct.db,
		`SELECT ClassId, ClassGroupIds, Count, ClassName, ClassType, ClassLocation
		FROM Classes
		WHERE ClassTeacherId = $1 AND Week = $2 AND Weekday = $3;`,
		c.Id, c.Week, c.Weekday)
	if err != nil {
		return nil, fmt.Errorf("Class.GetById: %v", err)
	}

	var resultClasses []Class
	var resultClass Class

	for rows.Next() {
		rows.Scan(&resultClass.Id, pq.Array(&resultClass.Groups), &resultClass.Count, &resultClass.Name, &resultClass.Type, &resultClass.Location)
		resultClass.Teacher, resultClass.Week, resultClass.Weekday = c.Teacher, c.Week, c.Weekday
		resultClasses = append(resultClasses, resultClass)
	}

	return &resultClasses, nil
}

func (ct *classTable) Delete(c *Class) error {
	if c.isDefault() {
		return errors.New("Class.Delete: wrong data! provided *Class is empty")
	}

	err := ct.qm.makeDelete(ct.db,
		"DELETE FROM Classes WHERE ClassId = $1",
		c.Id)

	if err != nil {
		return fmt.Errorf("Class.Delete: %v", err)
	}

	return nil
}
