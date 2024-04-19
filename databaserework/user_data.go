package databaserework

type UserData struct {
	Id         int    `json:"id"`
	Name       string `json:"name"`
	Bio        string `json:"bio"`
	UsefulData string `json:"useful_data"`
	Role       string `json:"role"`
}
