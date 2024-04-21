package database

import (
	"database/sql"
	"errors"
	"fmt"
)

// Структура объявления
type Advertisement struct {
	Id      int    `json:"ad_id"`      // id объявления
	Content string `json:"ad_content"` // содержание объявления (текст)
}

// isDefault проверяет, переданы ли какие-либо данные в структуру Advertisement
func (a *Advertisement) isDefault() bool {
	return a.Id == 0 || a.Content == ""
}

// advertisementTable предоставляет методы для работы с таблицей Advertisements
type advertisementTable struct {
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
func (at *advertisementTable) Add(a *Advertisement) error {
	// Проверяем были ли переданы данные в a
	if a.isDefault() {
		return errors.New("Advertisement.Add: wrong data! provided *Advertisement is empty")
	}

	// Используем queryMaker для создания и исполнения insert запроса
	err := at.qm.makeInsert(at.db,
		"INSERT INTO Advertisements (Content) VALUES ($1)",
		&a.Content,
	)

	if err != nil {
		return fmt.Errorf("Advertisement.Add: %v", err)
	}

	return nil
}

// GetById удаляет данные из базы данных по заданному Id.
// Принимает указатель на Advertisement с непустым полем GetById,
// возвращает заполненный *Advertisement и nil при успешном запросе.
//
// Прим:\n
// a := &Advertisement{Id:123} // Id != 0 !!!!!!\n
// ad, err := ...GetById(a) // err == nil если все хорошо
func (at *advertisementTable) GetById(a *Advertisement) (*Advertisement, error) {
	// Проверяем передан ли ID рекламного объявления
	if a.Id == 0 {
		return nil, errors.New("Advertisement.GetById: wrong data! provided advertisementID is empty")
	}

	// Используем базовую функцию для формирования и исполнения select запроса
	rows, err := at.qm.makeSelect(at.db,
		"SELECT Content FROM Advertisements WHERE AdvertiesmentId = $1",
		a.Id,
	)
	if err != nil {
		return nil, fmt.Errorf("Advertisement.GetByID: %v", err)
	}
	defer rows.Close()

	// Создаем переменную для хранения информации о рекламном объявлении
	var adv Advertisement

	// Извлекаем информацию из результата запроса и заполняем структуру Advertisement
	if rows.Next() {
		if err := rows.Scan(&adv.Content); err != nil {
			return nil, err
		}
	} else {
		return nil, errors.New("Advertisement.GetByID: no rows returned")
	}

	return &adv, nil
}

// GetById удаляет данные из базы данных по заданному Id.
// Принимает указатель на Advertisement с непустым полем GetById,
// возвращает nil при успешном удалении.
//
// Прим:\n
// a := &Advertisement{Id:123} // Id != 0 !!!!!!\n
// err := ...Delete(a) // err == nil если все хорошо
func (at *advertisementTable) Delete(a *Advertisement) error {
	// Проверяем передан ли ID рекламного объявления
	if a.Id == 0 {
		return errors.New("Advertisement.Delete: wrong data! provided advertisementID is empty")
	}

	// Используем queryMaker для удаления объявления
	err := at.qm.makeDelete(at.db,
		"DELETE FROM Advertisements WHERE AdvertiesmentId = $1",
		a.Id,
	)
	if err != nil {
		return fmt.Errorf("Advertisement.DeleteAdvertisement: %v", err)
	}

	// Возвращаем nil, так как ошибок не случилось
	return nil
}
