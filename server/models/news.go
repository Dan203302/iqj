package models

// Структура блочной новости
type NewsBlock struct {
	ID              string `json:"id"`
	Header          string `json:"header"`
	Link            string `json:"link"`
	ImageLink       string `json:"image_link"`
	PublicationTime string `json:"publication_time"`
}

// Структура полной новости
type News struct {
	ID              string `json:"id"`
	Header          string `json:"header"`
	Text            string `json:"text"`
	ImageLink       string `json:"image_link"`
	PublicationTime string `json:"publication_time"`
}
