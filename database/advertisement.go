package database

import (
	"database/sql"
	"errors"
	"fmt"
	"time"
)

// Структура объявления
type Advertisement struct {
	Id             int    `json:"ad_id"`           // id объявления
	Content        string `json:"ad_content"`      // содержание объявления (текст)
	CreationDate   string `json:"creation_date"`   // дата создания объявления
	ExpirationDate string `json:"expiration_date"` // срок годности объявления
}

// isDefault проверяет, переданы ли какие-либо данные в структуру Advertisement
func (a *Advertisement) isDefault() bool {
	return a.Id == 0 && a.Content == ""
}

// AdvertisementTable предоставляет методы для работы с таблицей Advertisements
type AdvertisementTable struct {
	db *sql.DB    // Указатель на подключение к базе данных
	qm queryMaker // Исполнитель ОБЫЧНЫХ sql запросов (см. query_maker.go)
}

// Add добавляет данные в базу данных.
// Принимает указатель на Advertisement с непустым полeм Content\n
// Возвращает nil при успешном добавлении.
//
// Прим:\n
// a := &Advertisement{Content : "123"} // Content != "" !!!!!!\n
// err := ...Add(a) // err == nil если все хорошо
func (at *AdvertisementTable) Add(a *Advertisement) error {
	// Проверяем были ли переданы данные в a
	if a.isDefault() {
		return errors.New("Advertisement.Add: wrong data! provided *Advertisement is empty")
	}

	// Используем queryMaker для создания и исполнения insert запроса
	err := at.qm.makeInsert(at.db,
		`INSERT INTO advertisements (content, creation_date, expiration_date)
		VALUES ($1, $2, $3)
		WHERE NOT EXISTS (
			SELECT 1 FROM advertisements WHERE content = $1 AND creation_date = $2
			)
		`,
		&a.Content, &a.CreationDate, &a.ExpirationDate,
	)

	if err != nil {
		return fmt.Errorf("Advertisement.Add: %v", err)
	}

	return nil
}

// Get возвращает объявления из бд срок годности которых больше текущей даты.
// Возвращает заполненный *[]Advertisement и nil при успешном запросе.
//
// Прим:\n
// ads, err := ...Get() // err == nil если все хорошо
func (at *AdvertisementTable) Get() (*[]Advertisement, error) {
	rows, err := at.qm.makeSelect(at.db,
		"SELECT content FROM advertisements WHERE expiration_date > $1 ORDER BY creation_date DESC",
		time.Now(),
	)

	if err != nil {
		return nil, fmt.Errorf("News.GetLatest: %v", err)
	}

	var resultAdvertisementArr []Advertisement
	var resultAdvertisement Advertisement

	for rows.Next() {
		rows.Scan(&resultAdvertisement.Content)
		resultAdvertisementArr = append(resultAdvertisementArr, resultAdvertisement)
	}

	return &resultAdvertisementArr, nil
}

// Delete удаляет данные из базы данных по заданному Id.
// Принимает указатель на Advertisement с заполненным полем Id,
// возвращает nil при успешном удалении.
//
// Прим:\n
// a := &Advertisement{Id:123} // Id != 0 !!!!!!\n
// err := ...Delete(a) // err == nil если все хорошо
func (at *AdvertisementTable) Delete(a *Advertisement) error {
	// Проверяем передан ли ID рекламного объявления
	if a.Id == 0 {
		return errors.New("Advertisement.Delete: wrong data! provided advertisementID is empty")
	}

	// Используем queryMaker для удаления объявления
	err := at.qm.makeDelete(at.db,
		"DELETE FROM advertisements WHERE advertiesmentId = $1",
		a.Id,
	)
	if err != nil {
		return fmt.Errorf("Advertisement.DeleteAdvertisement: %v", err)
	}

	// Возвращаем nil, так как ошибок не случилось
	return nil
}
