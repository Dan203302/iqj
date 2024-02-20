package models

type News struct {
	Id              int    `json:"id"`
	Header          string `json:"header"`
	Text            string `json:"text"`
	ImageLink       string `json:"image_link"`
	PublicationTime string `json:"publication_time"`
}
