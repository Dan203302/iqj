package database

type Authorization interface {
	Add(u User) error
}

type NewsRepo interface {
}

type AdvertisementRepo interface {
}

type Schedule interface {
}

type Repository struct {
	Authorization
	NewsRepo
	AdvertisementRepo
	Schedule
}

func NewRepository() *Repository {
	return &Repository{}
}
