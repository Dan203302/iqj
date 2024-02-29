package scraper

import (
	"github.com/gocolly/colly"
	"iqj/server/models"
	"time"
)

// Тикер, который запускает функцию каждые 30 секунд
func ScrapTick() {
	ticker := time.NewTicker(30 * time.Second)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			Scraper()
		}
	}
}

func Scraper() {
	scraper("https://www.mirea.ru/news/index.php?set_filter=Y&arrFilter_ff%5BTAGS%5D=%D1%81%D0%BE%D1%82%D1%80%D1%83%D0%B4%D0%BD%D0%B8%D0%BA%D0%B0%D0%BC")
	//scraper2(x)
}

// Получаем данные из всех блочных новостей
func scraper(url string) []models.NewsBlock {
	var newsblarr []models.NewsBlock
	c := colly.NewCollector()
	c.OnHTML(".uk-card.uk-card-default", func(e *colly.HTMLElement) {
		newsblock := models.NewsBlock{}

		x := e.ChildText(".uk-link-reset")
		newsblock.Header = x[:len(x)-18]
		newsblock.Link = "https://www.mirea.ru" + e.ChildAttr(".uk-link-reset", "href")
		newsblock.PublicationTime = e.ChildText(".uk-margin-small-bottom.uk-text-small")
		newsblock.ImageLink = "https://www.mirea.ru" + e.ChildAttr(".enableSrcset", "data-src")
		// Работа с файлом
		flag := checkbl(newsblock.ImageLink)
		if flag == true {
			newsblarr = append(newsblarr, newsblock)
		}
	})

	// Переключение на следующую страницу
	//c.OnHTML(".bx-pag-next a", func(e *colly.HTMLElement) {
	//	nextPage := e.Request.AbsoluteURL(e.Attr("href"))
	//	c.Visit(nextPage)
	//})

	c.Visit(url)

	x := Exportbl(newsblarr)
	return x
}

//// Получаем данные из всех полных новостей
//func scraper2(newsblarr []models.NewsBlock) {
//var newsarr []models.News
//	c := colly.NewCollector()
//	c.OnHTML(".uk-width-1-1", func(e *colly.HTMLElement) {
//		news := models.News{}
//		news.Header = e.Attr("h1")                                  // не работат выводит пустоту
//		news.Text = e.ChildText(".news-item-text.uk-margin-bottom") // работает
//		news.ImageLink = e.ChildText(".uk-card")                    // не работает
//		x := []byte(e.ChildText(".uk-margin-bottom"))
//		news.PublicationTime = string(x[:10]) // работает
//		// Работа с файлом
//		flag := check(news.ImageLink)
//		if flag == true {
//			newsarr = append(newsarr, news)
//		}
//	})
//
//	for i := range newsblarr {
//		c.Visit(newsblarr[i].Link)
//	}
//
//	c.Visit("https://www.mirea.ru/news/prepodavateli-instituta-mezhdunarodnogo-obrazovaniya-prinyali-uchastie-v-nauchno-prakticheskoy-konfe/")
//Export(newsarr)
//}
