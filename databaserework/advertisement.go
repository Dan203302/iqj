package databaserework

import (
	"database/sql"
	"errors"
	"fmt"
)

// Advertisement представляет информацию о рекламном объявлении
type Advertisement struct {
	Id      int    `json:"id"`
	Content string `json:"content"`
}

// isDefault проверяет, переданы ли какие-либо данные в структуру Advertisement
func (a *Advertisement) isDefault() bool {
	return a.Id == 0 || a.Content == ""
}

// advertisementTable предоставляет методы для работы с таблицей tblAdvertiesments
type advertisementTable struct {
	db *sql.DB
	qm queryMaker
}

// AddAdvertisement добавляет новое рекламное объявление в базу данных
func (at *advertisementTable) Add(a *Advertisement) error {
	// Проверяем были ли переданы данные в adv
	if a.isDefault() {
		return errors.New("Advertisement.Add: wrong data! provided *Advertisement is empty")
	}

	// Используем базовую функцию для создания и исполнения insert запроса
	err := at.qm.makeInsert(at.db,
		"INSERT INTO Advertisements (Content) VALUES ($1)",
		&a.Content,
	)

	if err != nil {
		return fmt.Errorf("Advertisement.Add: %v", err)
	}

	return nil
}

// GetAdvertisementByID получает информацию о рекламном объявлении по его идентификатору
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
		return nil, errors.New("Advertisement.GetAdvertisementByID: no rows returned")
	}

	return &adv, nil
}

// DeleteAdvertisement удаляет рекламное объявление по его идентификатору
func (at *advertisementTable) Delete(a *Advertisement) error {
	// Проверяем передан ли ID рекламного объявления
	if a.Id == 0 {
		return errors.New("Advertisement.Delete: wrong data! provided advertisementID is empty")
	}

	// Используем базовую функцию для удаления рекламного объявления
	err := at.qm.makeDelete(at.db,
		"DELETE FROM Advertisements WHERE AdvertiesmentId = $1",
		a.Id,
	)
	if err != nil {
		return fmt.Errorf("Advertisement.DeleteAdvertisement: %v", err)
	}

	return nil
}
