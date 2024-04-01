package database

import (
	"fmt"
	"github.com/lib/pq"
	"iqj/models"
	"time"
)

func (st *Storage) AddNews(newsBlock models.NewsBlock, newsText string) error {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()
	publicationTime := time.Now().Format("2006-01-02 15:04:05")

	var count int
	err := st.Db.QueryRow("SELECT COUNT(*) FROM news WHERE header = $1", newsBlock.Header).Scan(&count)
	if err != nil {
		return err
	}

	if count == 0 {
		_, err = st.Db.Exec("INSERT INTO news (header, link, news_text, image_link, publication_time) VALUES ($1, $2, $3, $4, $5)",
			newsBlock.Header, newsBlock.Link, newsText, pq.Array(newsBlock.ImageLink), publicationTime)
		if err != nil {
			return err
		}
	} else {
		return fmt.Errorf("news is already existing in database")
	}

	return nil
}

// Выдает блоки новостей от новых к старым, offset - промежуток пропуска (если первый запрос то 0), count - количество блоков
func (st *Storage) GetLatestNewsBlocks(offset, count int) (*[]models.NewsBlock, error) {

	rows, err := st.Db.Query("SELECT id, header, link, image_link, publication_time FROM news ORDER BY publication_time DESC LIMIT $1 OFFSET $2", count, offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var latestNewsBlocks []models.NewsBlock

	for rows.Next() {
		var id, header, link, publicationTime string
		var imageLinks []string
		err := rows.Scan(&id, &header, &link, pq.Array(&imageLinks), &publicationTime)
		if err != nil {
			return nil, err
		}
		newsBlock := models.NewsBlock{
			ID:              id,
			Header:          header,
			Link:            link,
			ImageLink:       imageLinks,
			PublicationTime: publicationTime,
		}
		latestNewsBlocks = append(latestNewsBlocks, newsBlock)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return &latestNewsBlocks, nil
}

// Выдает полную новость по заданному ID
func (st *Storage) GetNewsByID(id int) (*models.News, error) {
	row := st.Db.QueryRow("SELECT header, news_text, image_link, publication_time FROM news WHERE id = $1", id)

	var header, text, publicationTime string
	var imageLink []string

	err := row.Scan(&header, &text, pq.Array(&imageLink), &publicationTime)
	if err != nil {
		return nil, err
	}

	news := models.News{
		Header:          header,
		Text:            text,
		ImageLink:       imageLink,
		PublicationTime: publicationTime,
	}

	return &news, nil
}
