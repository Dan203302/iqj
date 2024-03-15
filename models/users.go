package models

type User struct {
	Id       int
	Name     string
	Password string
	Bio      string // федя решил что нам это нужно
	Role     string
}

type Student struct {
	Id       int // Совпадает с User.Id
	Group    string
	Teachers []string // id учителей
}

type Teacher struct {
	Id     int   // Совпадает с User.Id
	Groups []int // id групп
}
