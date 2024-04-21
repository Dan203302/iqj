package databaserework

import (
	"database/sql"
	"errors"
	"fmt"
	"time"

	"github.com/lib/pq"
)

/*
Сущность статьи (новости), может отдельно использоваться как News, так и как NewsBlock,
подробнее смотрите в database/news.go
*/
type News struct {
	Id              int      `json:"id"`
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
	return n.Id == 0 || n.Header == "" || n.Link == "" || n.Content == "" || n.ImageLinks == nil || n.Tags == nil || n.PublicationTime == ""
}

// Структура для более удобного и понятного взаимодействия с таблицой users
type newsTable struct {
	db *sql.DB
	qm queryMaker
}

func (nt *newsTable) Add(n *News) error {

	// Проверяем были ли переданы данные в u
	if n.isDefault() {
		return errors.New("News.Add: wrong data! provided *News is empty")
	}

	formattedDate, err := time.Parse("02.01.2006", n.PublicationTime)
	if err != nil {
		return err
	}
	n.PublicationTime = formattedDate.Format("2006-01-02 15:04:05")

	// Выполняем дефолтный инсерт в базу данных (вставка в таблицу)
	err = nt.qm.makeInsert(nt.db,
		`INSERT INTO News (Header, Link, NewsText, ImageLinks, Tags, PubliactionTime)
			SELECT $1, $2, $3, $4, $5, $6
			WHERE NOT EXISTS (
    		SELECT 1 FROM News WHERE Header = $1 AND PubliactionTime = $6
)
`,
		n.Header, n.Link, n.Content, n.ImageLinks, n.Tags, n.PublicationTime)

	if err != nil {
		return fmt.Errorf("News.Add: %v", err)
	}

	return nil
}

func (nt *newsTable) GetById(n *News) (*News, error) {
	if n.isDefault() {
		return nil, errors.New("News.GetById: wrong data! provided *News is empty")
	}

	if n.Id == 0 {
		return nil, errors.New("News.Delete: wrong data! provided *News has empty ID")
	}

	rows, err := nt.qm.makeSelect(nt.db,
		"SELECT Header, Link, NewsText, ImageLinks, Tags, PublicationTime FROM News WHERE NewsId = $1",
		n.Id,
	)

	if err != nil {
		return nil, fmt.Errorf("News.GetById: %v", err)
	}

	if rows.Next() {
		rows.Scan(n.Header, n.Link, n.Content, pq.Array(n.ImageLinks), pq.Array(n.Tags), n.PublicationTime)
	} else {
		return nil, errors.New("News.GetById: could not find any News with provided *News.Id")
	}

	return n, nil
}

func (nt *newsTable) GetLatestBlocks(count, offset int) (*[]News, error) {

	rows, err := nt.qm.makeSelect(nt.db,
		"SELECT NewsId, Header, Link, ImageLinks, PublicationTime FROM News ORDER BY PublicationTime DESC LIMIT $1 OFFSET $2",
		count, offset,
	)

	if err != nil {
		return nil, fmt.Errorf("News.GetLatest: %v", err)
	}

	var resultNewsArr []News
	var resultNews News

	for rows.Next() {
		rows.Scan(&resultNews.Id, &resultNews.Header, &resultNews.Link, pq.Array(&resultNews.ImageLinks), resultNews.PublicationTime)
		resultNewsArr = append(resultNewsArr, resultNews)
	}

	return &resultNewsArr, nil
}

func (nt *newsTable) Delete(n *News) error {
	if n.isDefault() {
		return errors.New("News.Delete: wrong data! provided *News is empty")
	}

	if n.Id == 0 {
		return errors.New("News.Delete: wrong data! provided *News has empty ID")
	}

	err := nt.qm.makeDelete(nt.db,
		"DELETE FROM News WHERE NewsId = $1",
		n.Id)

	if err != nil {
		return fmt.Errorf("News.Delete: %v", err)
	}

	return nil
}
