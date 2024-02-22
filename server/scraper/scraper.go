package scraper

import (
	"encoding/json"
	"github.com/gocolly/colly"
	"log"
	"os"
)

func Scraper() {
	scraper("https://www.mirea.ru/news/index.php?set_filter=Y&arrFilter_ff%5BTAGS%5D=%D1%81%D0%BE%D1%82%D1%80%D1%83%D0%B4%D0%BD%D0%B8%D0%BA%D0%B0%D0%BC")
	Exportbl(newsblarr)
	//scraper2()
	//Export(newsarr)
}

var newsblarr []NewsBlock
var newsarr []News

// Структура блочной новости
type NewsBlock struct {
	Header          string `json:"header"`
	Link            string `json:"link"`
	ImageLink       string `json:"image_link"`
	PublicationTime string `json:"publication_time"`
}

// Структура полной новости
type News struct {
	Header          string `json:"header"`
	Text            string `json:"text"`
	ImageLink       string `json:"image_link"`
	PublicationTime string `json:"publication_time"`
}

// Запись блочной новости в файл
func Exportbl(newsbl []NewsBlock) {
	file, err := os.Create("newsblock.json")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	jsonString, _ := json.MarshalIndent(newsbl, " ", " ")
	file.Write(jsonString)
}

//// Запись полной новости в файл
//func Export(newsbl []News) {
//	file, err := os.Create("news.json")
//	if err != nil {
//		log.Fatal(err)
//	}
//	defer file.Close()
//	jsonString, _ := json.MarshalIndent(newsbl, " ", " ")
//	file.Write(jsonString)
//}

// Получаем данные из всех блочных новостей
func scraper(url string) {
	c := colly.NewCollector()
	c.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
	c.OnHTML(".uk-card.uk-card-default", func(e *colly.HTMLElement) {
		newsblock := NewsBlock{}
		x := e.ChildText(".uk-link-reset")
		newsblock.Header = x[:len(x)-18]
		newsblock.Link = "https://www.mirea.ru" + e.ChildAttr(".uk-link-reset", "href")
		newsblock.PublicationTime = e.ChildText(".uk-margin-small-bottom.uk-text-small")
		newsblock.ImageLink = "https://www.mirea.ru" + e.ChildAttr(".enableSrcset", "data-src")
		newsblarr = append(newsblarr, newsblock)
	})

	c.OnHTML(".bx-pag-next a", func(e *colly.HTMLElement) {
		nextPage := e.Request.AbsoluteURL(e.Attr("href"))
		c.Visit(nextPage)
	})

	c.Visit(url)
}

//// Получаем данные из всех полных новостей
//func scraper2() {
//	c := colly.NewCollector()
//	c.OnHTML(".uk-width-1-1", func(e *colly.HTMLElement) {
//		news := News{}
//		news.Header = e.Attr("h1")                                  // не работат выводит пустоту
//		news.Text = e.ChildText(".news-item-text.uk-margin-bottom") // работает
//		news.ImageLink = e.ChildText(".uk-card")                    // не работает
//		x := []byte(e.ChildText(".uk-margin-bottom"))
//		news.PublicationTime = string(x[:10]) // работает
//		newsarr = append(newsarr, news)
//	})
//
//	for i := range newsblarr {
//		c.Visit(newsblarr[i].Link)
//	}
//
//	c.Visit("https://www.mirea.ru/news/prepodavateli-instituta-mezhdunarodnogo-obrazovaniya-prinyali-uchastie-v-nauchno-prakticheskoy-konfe/")
//
//}
