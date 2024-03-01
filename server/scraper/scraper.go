package scraper

import (
	"github.com/gocolly/colly"
	"iqj/server/models"
	"strings"
	"time"
)

// Тикер, который запускает функцию каждые 30 секунд
func ScrapTick() {
	ticker := time.NewTicker(10 * time.Second)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			Scraper()
		}
	}
}

func Scraper() {
	x := scraper("https://www.mirea.ru/news/index.php?set_filter=Y&arrFilter_ff%5BTAGS%5D=%D1%81%D0%BE%D1%82%D1%80%D1%83%D0%B4%D0%BD%D0%B8%D0%BA%D0%B0%D0%BC")
	scraper2(x)
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
	x := newsblarr
	Exportbl(newsblarr)
	return x
}

// Получаем данные из всех полных новостей
func scraper2(newsblarr []models.NewsBlock) {
	var newsarr []models.News
	c := colly.NewCollector()
	news := models.News{}
	var title, text string

	c.OnHTML("h1", func(e *colly.HTMLElement) {
		title = e.Text
	})

	c.OnHTML(".news-item-text", func(e *colly.HTMLElement) {
		text = e.Text
	})

	var mas []string
	c.OnHTML("a[data-fancybox=\"gallery\"]", func(e *colly.HTMLElement) {
		mas = append(mas, "https://www.mirea.ru"+e.ChildAttr("img", "src"))
	})

	for i := range newsblarr {
		c.Visit(newsblarr[i].Link)
		news.Header = title
		news.Text = text
		news.ImageLink = strings.Join(mas, ", ")
		mas = nil
		news.PublicationTime = newsblarr[i].PublicationTime
		flag := check(news.ImageLink)
		if flag == true {
			newsarr = append(newsarr, news)
		}
	}
	Export(newsarr)
}
