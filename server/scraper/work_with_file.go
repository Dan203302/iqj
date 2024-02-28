package scraper

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os"
	"strings"
)

// Запись блочной новости в файл
func Exportbl(newsblarr []NewsBlock) {
	file, err := os.Open("newsblock.json")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	var newsbl3 []NewsBlock
	decoder := json.NewDecoder(file)

	if err = decoder.Decode(&newsbl3); err != nil {
		fmt.Println(err)
	}

	for i := range newsbl3 {
		newsblarr = append(newsblarr, newsbl3[i])
	}

	if file, err = os.Create("newsblock.json"); err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	encoder := json.NewEncoder(file)
	encoder.SetIndent("", "\t")
	if err = encoder.Encode(newsblarr); err != nil {
		log.Fatal(err)
	}

}

//// Запись полной новости в файл
//func Export(newsarr []News) {
//	file, err := os.Open("news.json")
//	if err != nil {
//		log.Fatal(err)
//	}
//	defer file.Close()
//
//	var news3 []NewsBlock
//	decoder := json.NewDecoder(file)
//
//	if err = decoder.Decode(&news3); err != nil {
//		fmt.Println(err)
//	}
//
//	for i := range news3 {
//		newsarr = append(newsarr, news3[i])
//	}
//
//	if file, err = os.Create("news.json"); err != nil {
//		log.Fatal(err)
//	}
//	defer file.Close()
//	encoder := json.NewEncoder(file)
//	encoder.SetIndent("", "\t")
//	if err = encoder.Encode(newsarr); err != nil {
//		log.Fatal(err)
//	}
//}

// Проверка наличия элемента в блочной новости
func checkbl(imagelink string) bool {
	flag := true
	fileOp, err := os.Open("newsblock.json")
	if err != nil {
		fmt.Println(err)
	}
	defer fileOp.Close()

	data, err := io.ReadAll(fileOp)
	if err != nil {
		fmt.Println(err)
	}
	var newsbl2 []NewsBlock

	err = json.Unmarshal(data, &newsbl2)
	if err != nil {
		fmt.Println(err)
	}
	for _, i := range newsbl2 {
		if strings.Contains(i.ImageLink, imagelink) {
			flag = false
		}
	}
	return flag
}

// Проверка наличия элемента в полной новости
func check(imagelink string) bool {
	flag := true
	fileOp, err := os.Open("news.json")
	if err != nil {
		fmt.Println(err)
	}
	defer fileOp.Close()

	data, err := io.ReadAll(fileOp)
	if err != nil {
		fmt.Println(err)
	}
	var news2 []NewsBlock

	err = json.Unmarshal(data, &news2)
	if err != nil {
		fmt.Println(err)
	}
	for _, i := range news2 {
		if strings.Contains(i.ImageLink, imagelink) {
			flag = false
		}
	}
	return flag
}
