package excelparser

import (
	"fmt"
	"iqj/config"
	"iqj/models"
	"os"
	"path/filepath"
	"strings"

	"github.com/360EntSecGroup-Skylar/excelize"
)

// Парсинг всех Excel файлов директории
func Parse(criterion string, value string) ([]models.Lesson, error) {
	var tables []models.Lesson
	directory := config.DirToParse //ПРОПИСАТЬ ПОЛНЫЙ ПУТЬ, ЕСЛИ НЕ РАБОТАЕТ
	files, err := os.ReadDir(directory)
	if err != nil {
		return tables, err
	}

	id := 0
	for _, file := range files {
		if strings.HasSuffix(file.Name(), ".xlsx") {
			filePath := filepath.Join(directory, file.Name())

			xlFile, err := excelize.OpenFile(filePath)
			if err != nil {
				fmt.Println("Ошибка открытия файла:", err)
				continue
			}

			table := xlFile.GetRows("Расписание занятий по неделям")
			var newTable []models.Lesson
			newTable, id, err = find(criterion, value, table, id)
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
