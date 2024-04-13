package models

type Ad struct {
	Id   int    `json:"id"`
	Text string `json:"text"`
	Flag bool   `json:"flag"`
}
