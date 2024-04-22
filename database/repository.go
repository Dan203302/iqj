package database

type Authorization struct {
}

type NewsRepo struct {
}

type AdvertisementRepo struct {
}

type Schedule struct {
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
