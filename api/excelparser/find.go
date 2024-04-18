package excelparser

// import (
// 	"iqj/models"
// 	"strings"
// )

// //TODO: Заменить заглушку на GroupID и TeacherID на поиск из БД

// // Получение критерия, значения и таблицы, возвращение массива уроков
// func find(criterion string, value string, table [][]string) ([]models.Lesson, error) {
// 	var valueTable []models.Lesson
// 	weekdayIndex := []int{3, 17, 31, 45, 59, 73, 87}
// 	var id, groupid, teacherid int
// 	//Поиск по группе
// 	if criterion == "group" {
// 		n := 0
// 		// Запоминание номера столбца с нужной группой
// 		for i := 0; i < len(table[1]); i++ {
// 			if table[1][i] == value {
// 				n = i
// 				break
// 			}
// 		}
// 		if n == 0 {
// 			return nil, nil
// 		}

// 		for i := 3; i < 88; i++ {
// 			var row models.Lesson
// 			for j := 0; j < len(weekdayIndex); j++ {
// 				if weekdayIndex[j] > i {
// 					row.Weekday = j
// 					break
// 				}
// 			}
// 			row.Id = id
// 			row.GroupID = groupid //table[1][n]
// 			row.LessonName = table[i][n]
// 			row.TeacherID = teacherid //[i][n+2]
// 			row.Location = table[i][n+3]

// 			valueTable = append(valueTable, row)
// 			id++
// 			groupid++
// 			teacherid++
// 		}
// 		//Поиск по преподавателю
// 	} else if criterion == "tutor" {
// 		var pairs [][]int
// 		var pair []int
// 		iter := 5
// 		// Запоминание ячеек с именем препода
// 		for i := 0; i < 87; i++ {
// 			for j := 7; j < len(table[2]); j += iter {
// 				if (strings.Contains(table[i][j], value) && strings.Contains(table[i][j], "\n")) || table[i][j] == value {
// 					pair = append(pair, i, j)
// 					pairs = append(pairs, pair)
// 					pair = nil
// 				}
// 				// Парсинг в зависимости от положения группы в таблице
// 				if iter == 5 {
// 					iter = 10
// 				} else {
// 					iter = 5
// 				}
// 			}
// 		}
// 		if len(pairs) == 0 {
// 			return nil, nil
// 		}
// 		var rowNum int
// 		var colNum int
// 		// Закидывание инфы о паре
// 		for i := 0; i < len(pairs); i++ {
// 			rowNum = pairs[i][0]
// 			colNum = pairs[i][1]
// 			var row models.Lesson
// 			for j := 0; j < len(weekdayIndex); j++ {
// 				if weekdayIndex[j] > rowNum {
// 					row.Weekday = j - 1
// 					break
// 				}
// 			}
// 			// Парсинг в зависимости от положения группы в таблице
// 			if table[rowNum][colNum-3] == "I" || table[rowNum][colNum-3] == "II" {
// 				row.Id = id
// 				row.TeacherID = teacherid //table[rowNum][colNum]
// 				row.GroupID = groupid     //table[1][colNum-2]
// 				row.LessonName = table[rowNum][colNum-2]
// 				row.Location = table[rowNum][colNum+1]
// 				valueTable = append(valueTable, row)
// 			} else {
// 				row.Id = id
// 				row.TeacherID = teacherid //table[rowNum][colNum]
// 				row.GroupID = groupid     //table[1][colNum-2]
// 				row.LessonName = table[rowNum][colNum-2]
// 				row.Location = table[rowNum][colNum+1]
// 				valueTable = append(valueTable, row)
// 			}
// 			id++
// 			groupid++
// 			teacherid++
// 		}
// 		//Поиск по аудитории
// 	} else if criterion == "classroom" {
// 		var pairs [][]int
// 		var pair []int
// 		iter := 5
// 		for i := 0; i < 87; i++ {
// 			for j := 8; j < len(table[2]); j += iter {
// 				if (strings.Contains(table[i][j], value) && strings.Contains(table[i][j], "\n")) || table[i][j] == value {
// 					pair = append(pair, i, j)
// 					pairs = append(pairs, pair)
// 					pair = nil
// 				}
// 				if iter == 5 {
// 					iter = 10
// 				} else {
// 					iter = 5
// 				}
// 			}
// 		}
// 		if len(pairs) == 0 {
// 			return nil, nil
// 		}
// 		var rowNum int
// 		var colNum int
// 		for i := 0; i < len(pairs); i++ {
// 			rowNum = pairs[i][0]
// 			colNum = pairs[i][1]
// 			var row models.Lesson
// 			for j := 0; j < len(weekdayIndex); j++ {
// 				if weekdayIndex[j] > rowNum {
// 					row.Weekday = j - 1
// 					break
// 				}
// 			}
// 			if table[rowNum][colNum-4] == "I" || table[rowNum][colNum-4] == "II" {
// 				row.Id = id
// 				row.TeacherID = teacherid //table[rowNum][colNum-1]
// 				row.GroupID = groupid     //table[1][colNum-3]
// 				row.LessonName = table[rowNum][colNum-3]
// 				row.Location = table[rowNum][colNum]
// 				valueTable = append(valueTable, row)
// 			} else {
// 				row.Id = id
// 				row.TeacherID = teacherid //table[rowNum][colNum-1]
// 				row.GroupID = groupid     //table[1][colNum-3]
// 				row.LessonName = table[rowNum][colNum-3]
// 				row.Location = table[rowNum][colNum]
// 				valueTable = append(valueTable, row)
// 			}
// 			id++
// 			groupid++
// 			teacherid++
// 		}
// 	}

// 	return valueTable, nil
// }
