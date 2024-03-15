package database

import (
	_ "github.com/dgrijalva/jwt-go"
	"iqj/models"
)

//	func (st *Storage) SearchUser(user *models.User, token *jwt.StandardClaims) error {
//		err := st.Db.QueryRow("SELECT id, username, password FROM users WHERE id = $1", token.Issuer).
//			Scan(&user.Id, &user.Name, &user.Role)
//		return err
//	}
//
// Добавляет пользователя по полученной модели (необходимы name, password, role)
func (st *Storage) AddUser(user *models.User) error {
	//TODO: ребята пожалуйста организуйте подачу паролей через bcrypt
	_, err := st.Db.Exec("INSERT INTO users (name, password,role) VALUES ($1, $2, $3)",
		user.Name, user.Password, user.Role)

	return err
}

// Меняет био пользователя по полученной модели (необходимы bio и id)
func (st *Storage) ChangeBio(user *models.User) error {
	_, err := st.Db.Exec("UPDATE users SET bio = $1 WHERE ID = $2", user.Bio, user.Id)

	return err
}

// Меняет имя пользователя по полученной модели (необходимы name и id)
func (st *Storage) ChangeName(user *models.User) error {
	_, err := st.Db.Exec("UPDATE users SET name = $1 WHERE ID = $2", user.Name, user.Id)

	return err
}
