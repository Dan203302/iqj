package handlers

import (
	"iqj/api/excelparser"
	"net/http"

	"github.com/gin-gonic/gin"
)

func Lessons(c *gin.Context) {
	criterion := c.Query("criterion")
	value := c.Query("value")

	lessons, err := excelparser.Parse(criterion, value)
	if err != nil {
		c.String(http.StatusBadRequest, err.Error())
		return
	}

	var filteredLessons []excelparser.Lesson
	for _, lesson := range lessons {
		switch criterion {
		case "group":
			if lesson.Group == value {
				filteredLessons = append(filteredLessons, lesson)
			}
		case "tutor":
			if lesson.Teacher == value {
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
