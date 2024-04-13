package excelparser

//костыльная структура наподобие бдшной, позже поменяю
type Lesson struct {
	Id         int    `json: "id"`
	Group      string `json: "group"`
	Teacher    string `json: "teacher"`
	Weekday    int    `json: "weekday"`
	LessonName string `json: "lessonName"`
	Location   string `json: "location"`
}
