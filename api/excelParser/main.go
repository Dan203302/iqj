package main

import (
	"fmt"
	"strings"

	"github.com/360EntSecGroup-Skylar/excelize"
)

// Парсинг Excel файла
func parseSheet(sheet string) ([][]string, error) {
	var schedule, _ = excelize.OpenFile("schedule.xlsx")
	var table = schedule.GetRows(sheet)

	return table, nil
}

// Получение критерия и его значения, возвращение двумерного массива
func find(criterion string, value string) [][]string {
	table, _ := parseSheet("Расписание занятий по неделям")
	var valueTable [][]string
	//Поиск по группе
	if criterion == "group" {
		n := 0
		// Запоминание номера столбца с нужной группой
		for i := 0; i < len(table[1]); i++ {
			if strings.Contains(table[1][i], value) {
				n = i
				break
			}
		}
		if n == 0 {
			return valueTable
		}
		var row []string

		for i := 2; i < 87; i++ {
			// День недели, номер пары и т.д.
			for j := 0; j < 5; j++ {
				row = append(row, table[i][j])
			}
			// Основная инфа
			for j := n; j < n+5; j++ {
				row = append(row, table[i][j])
			}
			valueTable = append(valueTable, row)
			row = nil
		}
		//Поиск по преподавателю
	} else if criterion == "tutor" {
		var pairs [][]int
		var pair []int
		iter := 5
		table, _ := parseSheet("Расписание занятий по неделям")
		// Запоминание ячеек с именем препода
		for i := 0; i < 87; i++ {
			for j := 7; j < len(table[2]); j += iter {
				if strings.Contains(table[i][j], value) {
					pair = append(pair, i, j)
					pairs = append(pairs, pair)
					pair = nil
				}
				// Парсинг в зависимости от положения группы в таблице
				if iter == 5 {
					iter = 10
				} else {
					iter = 5
				}
			}
		}
		var row []string
		var rowNum int
		var colNum int
		// Закидывание инфы о паре
		for i := 0; i < len(pairs); i++ {
			rowNum = pairs[i][0]
			colNum = pairs[i][1]
			// Парсинг в зависимости от положения группы в таблице
			if table[rowNum][colNum-3] == "I" || table[rowNum][colNum-3] == "II" {
				for j := colNum - 7; j < colNum+2; j++ {
					row = append(row, table[rowNum][j])
				}
				valueTable = append(valueTable, row)
				row = nil
			} else {
				for j := colNum - 12; j < colNum-8; j++ {
					row = append(row, table[rowNum][j])
				}
				for j := colNum - 2; j < colNum+2; j++ {
					row = append(row, table[rowNum][j])
				}
				valueTable = append(valueTable, row)
				row = nil
			}

		}
		//Поиск по аудитории
	} else if criterion == "classroom" {
		var pairs [][]int
		var pair []int
		iter := 5
		table, _ := parseSheet("Расписание занятий по неделям")
		for i := 0; i < 87; i++ {
			for j := 8; j < len(table[2]); j += iter {
				if strings.Contains(table[i][j], value) {
					pair = append(pair, i, j)
					pairs = append(pairs, pair)
					pair = nil
				}
				if iter == 5 {
					iter = 10
				} else {
					iter = 5
				}
			}
		}
		var row []string
		var rowNum int
		var colNum int
		for i := 0; i < len(pairs); i++ {
			rowNum = pairs[i][0]
			colNum = pairs[i][1]
			if table[rowNum][colNum-4] == "I" || table[rowNum][colNum-4] == "II" {
				for j := colNum - 8; j < colNum; j++ {
					row = append(row, table[rowNum][j])
				}
				valueTable = append(valueTable, row)
				row = nil
			} else {
				for j := colNum - 13; j < colNum-9; j++ {
					row = append(row, table[rowNum][j])
				}
				for j := colNum - 3; j < colNum; j++ {
					row = append(row, table[rowNum][j])
				}
				valueTable = append(valueTable, row)
				row = nil
			}

		}
	}
	return valueTable
}

func main() {
	//fmt.Println(find("group", "ЭФБО-01-23"))
	//fmt.Println(find("tutor", "Сафронов А.А."))
	//fmt.Println(find("classroom", "ауд. А-61 (МП-1)"))
}

/* НУЖНО ДОДЕЛАТЬ

2. JSON-запрос, а не ввод с консоли (критерий, значение -> мини-таблица)
3. Раскидать по разным файлам
4. Парсинг Excel-файлов с сайта https://www.mirea.ru/schedule/
5. Косметические изменения (по возможности)
*/
