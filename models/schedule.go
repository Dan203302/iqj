package models

type Lesson struct {
	Id         int
	GroupID    []int
	TeacherID  int
	Count      int
	Weekday    int
	Week       int
	LessonName string
	LessonType string
	Location   string
}
