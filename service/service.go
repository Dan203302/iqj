package service

import "iqj/database"

type Authorization interface {
	Add(u database.User) error
}

type News interface {
}

type Advertisement interface {
}

type Schedule interface {
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
