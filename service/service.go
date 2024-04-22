package service

import "iqj/database"

type Authorization struct {
}

type News struct {
}

type Advertisement struct {
}

type Schedule struct {
}

type Service struct {
	Authorization
	News
	Advertisement
	Schedule
}

func NewService(repository *database.Repository) *Service {
	return &Service{}
}
