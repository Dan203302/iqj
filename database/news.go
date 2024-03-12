package database

import (
	"fmt"
	"iqj/server/models"
	"time"
)

func (st *Storage) AddNews(newsBlock models.NewsBlock, newsText string) error {
	publicationTime := time.Now().Format("2006-01-02 15:04:05")

	var count int
	err := st.Db.QueryRow("SELECT COUNT(*) FROM news WHERE header = ?", newsBlock.Header).Scan(&count)
	if err != nil {
		return err
	}

	if count == 0 {
		_, err = st.Db.Exec("INSERT INTO news (header, link, news_text, image_link, publication_time) VALUES (?, ?, ?, ?, ?)",
			newsBlock.Header, newsBlock.Link, newsText, newsBlock.ImageLink, publicationTime)
		if err != nil {
			return err
		}
	} else {
		return fmt.Errorf("news is already existing in database")
	}

	return nil
}

// Выдает блоки новостей от новых к старым, offset - промежуток пропуска (если первый запрос то 0), count - количество блоков
func (st *Storage) GetLatestNewsBlocks(offset, count int) ([]models.NewsBlock, error) {
	query := fmt.Sprintf("SELECT header, link, image_link, publication_time FROM news ORDER BY publication_time DESC LIMIT %d OFFSET %d", count, offset)

	rows, err := st.Db.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var latestNewsBlocks []models.NewsBlock

	for rows.Next() {
		var header, link, imageLink, publicationTime string
		err := rows.Scan(&header, &link, &imageLink, &publicationTime)
		if err != nil {
			return nil, err
		}
		newsBlock := models.NewsBlock{
			Header:          header,
			Link:            link,
			ImageLink:       imageLink,
			PublicationTime: publicationTime,
		}
		latestNewsBlocks = append(latestNewsBlocks, newsBlock)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return latestNewsBlocks, nil
}

// Выдает полную новость по заданному ID
func (st *Storage) GetNewsByID(id int) (models.News, error) {
	row := st.Db.QueryRow("SELECT header, news_text, image_link, publication_time FROM news WHERE id = ?", id)

	var header, text, imageLink, publicationTime string

	err := row.Scan(&header, &text, &imageLink, &publicationTime)
	if err != nil {
		return models.News{}, err
	}

	news := models.News{
		Header:          header,
		Text:            text,
		ImageLink:       imageLink,
		PublicationTime: publicationTime,
	}

	return news, nil
}
