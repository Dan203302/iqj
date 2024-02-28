package scraper

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
