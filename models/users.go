package models

type User struct {
	Id   int      `json:"id"`
	Name string   `json:"name"`
	Data UserData `json:"data"`
	Bio  string   `json:"bio"` // федя решил что нам это нужно
	Role string   `json:"role"`
}

type UserData struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type Student struct {
	Id       int      `json:"id"` // Совпадает с User.Id
	Group    string   `json:"group"`
	Teachers []string `json:"teachers"` // id учителей
}

type Teacher struct {
	Id     int   `json:"id"`     // Совпадает с User.Id
	Groups []int `json:"groups"` // id групп
}
