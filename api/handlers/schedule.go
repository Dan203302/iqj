package handlers

import (
	"iqj/api/excelparser"
	"net/http"

	"github.com/gin-gonic/gin"
)

// Получает criterion (group, tutor, classroom) и value из запроса, вызывает функцию Parse,
// которая вернет массив с расписанием по заданным критериям.
// Выдает расписание пользователю в формате JSON.
// Например при GET /lessons?criterion=group&value=ЭФБО-01-23 вернет расписание группы ЭФБО-01-23.
// При неверном критерии или значении отправит null

func Lessons(c *gin.Context) {
	criterion := c.Query("criterion")
	value := c.Query("value")

	lessons, err := excelparser.Parse(criterion, value)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
		return
	}

	var filteredLessons []models.Lesson
	for _, lesson := range lessons {
		switch criterion {
		case "group":
			if lesson.GroupID == nil { //заглушка value
				filteredLessons = append(filteredLessons, lesson)
			}
		case "tutor":
			if lesson.TeacherID == 0 { //заглушка value
				filteredLessons = append(filteredLessons, lesson)
			}

		case "classroom":
			if lesson.Location == value {
				filteredLessons = append(filteredLessons, lesson)
			}
		default:
			c.String(http.StatusBadRequest, err.Error())
			return
		}
	}

	c.JSON(http.StatusOK, filteredLessons)
}
