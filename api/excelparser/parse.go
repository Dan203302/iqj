package excelparser

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"iqj/api/handlers"

	"github.com/360EntSecGroup-Skylar/excelize"
)

// Парсинг всех Excel файлов директории
func Parse(criterion string, value string) ([]handlers.Lesson, error) {
	var tables []handlers.Lesson
	directory := "excelFiles"
	files, err := os.ReadDir(directory)
	if err != nil {
		return tables, err
	}

	for _, file := range files {
		if strings.HasSuffix(file.Name(), ".xlsx") {
			filePath := filepath.Join(directory, file.Name())

			xlFile, err := excelize.OpenFile(filePath)
			if err != nil {
				fmt.Println("Ошибка открытия файла:", err)
				continue
			}

			table := xlFile.GetRows("Расписание занятий по неделям")
			newTable, err := find(criterion, value, table)
			if err != nil {
				fmt.Println("Ошибка при парсинге:", err)
				return nil, err
			}
			for _, lesson := range newTable {
				tables = append(tables, lesson)
			}
		}
	}
	return tables, nil
}
