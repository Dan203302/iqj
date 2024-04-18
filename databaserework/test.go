package databaserework

// import (
// 	"fmt"
// 	"time"
// )

// // IntArray представляет пользовательский тип для целочисленного массива
// type IntArray []int

// // StringArray представляет пользовательский тип для строкового массива
// type StringArray []string

// // Value представляет пользовательский тип, который может быть одним из нескольких типов данных
// type Value interface{}

// // Filter представляет структуру с атрибутом keys, содержащим словарь с ключом по строке и значением типа Value
// type Filter1 struct {
// 	keys map[string]FilterValues
// }

// func (starr StringArray) lol() {

// }

// func (intarr IntArray) lol() {

// }

// type FilterValues interface {
// 	lol()
// }

// func main() {
// 	// Пример использования
// 	filter := Filter1{
// 		keys: make(map[string]FilterValues),
// 	}

// 	// Пример добавления значений различных типов в словарь
// 	filter.keys["time"] = time.Now()
// 	filter.keys["int"] = 42
// 	filter.keys["string"] = "Hello, world!"
// 	filter.keys["int[]"] = IntArray{1, 2, 3}
// 	filter.keys["string[]"] = StringArray{"apple", "banana", "orange"}
// 	filter.keys["lolol"] = float64(123)

// 	// Вывод значений словаря
// 	for key, value := range filter.keys {
// 		fmt.Printf("%s: %v\n", key, value)
// 	}
// }
