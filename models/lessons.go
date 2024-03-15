package models

type Lesson struct {
	Id         int
	GroupID    int
	TeacherID  int
	Weekday    int
	LessonName string
	Location   string
}
