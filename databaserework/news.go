package databaserework

import (
	"database/sql"
	"fmt"
	"sync"
)

/*
====== ФИЛЬТРЫ НАХОДЯТСЯ В КОНЦЕ ФАЙЛА ======
*/

/*
Сущность статьи (новости), может отдельно использоваться как News, так и как NewsBlock,
подробнее смотрите в database/news.go
*/
type News struct {
	ID              int      `json:"id"`
	Header          string   `json:"header"`
	Link            string   `json:"link,omitempty"`
	Content         string   `json:"content,omitempty"`
	ImageLinks      []string `json:"image_link"`
	Tags            []string `json:"tags"`
	PublicationTime string   `json:"publication_time"`
}

/*
Проверяет, переданы ли какие-либо данные в структуру.
Необходимо для реализаци интерфейса Entity, а также для фильтров в функциях БД
*/
func (n *News) isDefault() bool {
	return n.ID == 0 || n.Header == "" || n.Link == "" || n.Content == "" || n.ImageLinks == nil || n.Tags == nil || n.PublicationTime == ""
}

// Структура для более удобного и понятного взаимодействия с таблицой users
type newsTable struct {
	db *sql.DB
	mu *sync.Mutex
}

func (nt *newsTable) Add(n *News) error {

	// Проверяем были ли переданы данные в u
	if !n.isDefault() {
		return fmt.Errorf("News.Add: wrong data! provided *News is empty")
	}

	// Закрываем мьютекс для того, чтобы не было проблем с конкуретностью, надеюсь
	// когда нибудь перейдем на транзакции, но, как по мне, это слишком много
	// работы для бесплатного проекта
	nt.mu.Lock()
	defer nt.mu.Unlock()

	// Выполняем дефолтный инсерт в базу данных (вставка в таблицу)
	_, err := nt.db.Exec(
		"INSERT INTO news (header,link,content,image_links,tags,publication_time) VALUES ($1, $2, $3, $4, $5, $6)",
		n.Header, n.Link, n.Content, n.ImageLinks, n.Tags, n.PublicationTime)

	// если постгрес криво базарит
	if err != nil {
		return err
	}

	return nil

}

func (nt *newsTable) Get(n *News) (*[]*User, error) {
	if n.isDefault() {
		return nil, fmt.Errorf("News.Get: wrong data! provided *News is empty")
	}
	return nil, nil
}

func (ut *newsTable) new(db *sql.DB, mu *sync.Mutex) {
	ut.db, ut.mu = db, mu
}
