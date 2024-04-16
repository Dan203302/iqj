package database

import (
	"database/sql"
	"errors"
	"fmt"
	"iqj/models"

	_ "github.com/dgrijalva/jwt-go"
	"golang.org/x/crypto/bcrypt"
)

//	func (st *Storage) SearchUser(user *models.User, token *jwt.StandardClaims) error {
//		err := st.Db.QueryRow("SELECT id, username, password FROM users WHERE id = $1", token.Issuer).
//			Scan(&user.ID, &user.Name, &user.Role)
//		return err
//	}
//
// Добавляет пользователя по полученной модели (необходимы name, password, role), добавление данных в таблицу о студенте/преподавателе
func (st *Storage) AddUser(user *models.User) error {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	_, err := st.Db.Exec(
		"INSERT INTO users (name, email,password,role) VALUES ($1, $2, $3,$4)",
		user.Name, user.Data.Email, user.Data.Password, user.Role)
	if err != nil {
		return err
	}

	return nil
}

// Возвращает "incorrect password" при отсутствии пользователя в бд или неправильном пароле, nil при правильности пароля
func (st *Storage) CheckUser(user *models.User) (*models.User, error) {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	var passFromData string
	err := st.Db.QueryRow(
		"SELECT password,id FROM users WHERE email = $1",
		user.Data.Email).
		Scan(&passFromData, &user.Id)

	if errHash := bcrypt.CompareHashAndPassword([]byte(passFromData), []byte(user.Data.Password)); errors.Is(err, sql.ErrNoRows) || errHash != nil {
		fmt.Println(errHash, "ok")
		return nil, fmt.Errorf("incorrect password")
	}
	//if errors.Is(err, sql.ErrNoRows) || passFromData != user.Data.Password {
	//	return nil, fmt.Errorf("incorrect password")
	//}

	return user, nil
}

func (st *Storage) GetRole(user *models.User) (*models.User, error) {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	err := st.Db.QueryRow("SELECT role FROM users WHERE id = $1",
		user.Id).
		Scan(&user.Role)
	if err != nil {
		return nil, err
	}
	return user, nil
}

// Меняет био пользователя по полученной модели (необходимы bio и id)
func (st *Storage) ChangeBio(user *models.User) error {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	_, err := st.Db.Exec("UPDATE users SET bio = $1 WHERE ID = $2",
		user.Bio, user.Id)

	return err
}

// Меняет имя пользователя по полученной модели (необходимы name и id)
func (st *Storage) ChangeName(user *models.User) error {
	st.Mutex.Lock()
	defer st.Mutex.Unlock()

	_, err := st.Db.Exec("UPDATE users SET name = $1 WHERE ID = $2",
		user.Name, user.Id)

	return err
}
