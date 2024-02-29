package database

import (
	"fmt"
	"iqj/server/scraper"
	"time"
)

// TODO: ребята пж разберитесь с моделями, очень очень нужно структуру для блока с полем ID для дальнейшего доступа к полноценной новости
// я как бы мог и сам у вас подправить, но лучше будет если это сделаете вы
// и с картинками еще: просто массив строк объедините в строку, перечислая ссылка через запятую, так хранить будет сильно проще
func (st *Storage) AddNews(newsBlock scraper.NewsBlock, newsText string) error {
	publicationTime := time.Now().Format("2006-01-02 15:04:05")
	_, err := st.Db.Exec("INSERT INTO news (header, link, news_text, image_link, publication_time) VALUES (?, ?, ?, ?, ?)",
		newsBlock.Header, newsBlock.Link, newsText, newsBlock.ImageLink, publicationTime)
	if err != nil {
		return err
	}
	return nil
}

// Выдает блоки новостей от новых к старым, offset - промежуток пропуска (если первый запрос то 0), count - количество блоков
func (st *Storage) GetLatestNewsBlocks(offset, count int) ([]scraper.NewsBlock, error) {
	query := fmt.Sprintf("SELECT header, link, image_link, publication_time FROM news ORDER BY publication_time DESC LIMIT %d OFFSET %d", count, offset)

	rows, err := st.Db.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var latestNewsBlocks []scraper.NewsBlock

	for rows.Next() {
		var header, link, imageLink, publicationTime string
		err := rows.Scan(&header, &link, &imageLink, &publicationTime)
		if err != nil {
			return nil, err
		}
		newsBlock := scraper.NewsBlock{
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
func (st *Storage) GetNewsByID(id int) (scraper.News, error) {
	row := st.Db.QueryRow("SELECT header, news_text, image_link, publication_time FROM news WHERE id = ?", id)

	var header, text, imageLink, publicationTime string

	err := row.Scan(&header, &text, &imageLink, &publicationTime)
	if err != nil {
		return scraper.News{}, err
	}

	news := scraper.News{
		Header:          header,
		Text:            text,
		ImageLink:       imageLink,
		PublicationTime: publicationTime,
	}

	return news, nil
}
