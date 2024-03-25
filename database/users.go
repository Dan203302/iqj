package database

import (
	"database/sql"
	"errors"
	"fmt"
	_ "github.com/dgrijalva/jwt-go"
	"iqj/models"
)

//	func (st *Storage) SearchUser(user *models.User, token *jwt.StandardClaims) error {
//		err := st.Db.QueryRow("SELECT id, username, password FROM users WHERE id = $1", token.Issuer).
//			Scan(&user.Id, &user.Name, &user.Role)
//		return err
//	}
//
// Добавляет пользователя по полученной модели (необходимы name, password, role), добавление данных в таблицу о студенте/преподавателе
func (st *Storage) AddUser(user *models.User, student *models.Student, teacher *models.Teacher) error {
	//TODO: ребята пожалуйста организуйте подачу паролей через bcrypt
	_, err := st.Db.Exec("INSERT INTO users (name, email,password,role) VALUES ($1, $2, $3,$4)",
		user.Name, user.Data.Email, user.Data.Password, user.Role)
	if err != nil {
		return nil
	}

	// подавайте nil если не студент
	if student != nil {
		err = st.createStudent(student)
		if err != nil {
			return nil
		}
	}

	// подавайте nil если не преподаватель
	if teacher != nil {
		err = st.createTeacher(teacher)
		if err != nil {
			return nil
		}
	}

	return err
}

// Возвращает "incorrect password" при отсутствии пользователя в бд или неправильном пароле, nil при правильности пароля
func (st *Storage) CheckUser(user *models.User) error {
	var passFromData string
	err := st.Db.QueryRow("SELECT password FROM users WHERE email = $1", user.Data.Email).Scan(&passFromData)
	if errors.Is(err, sql.ErrNoRows) || passFromData != user.Data.Password {
		return fmt.Errorf("incorrect password")
	}
	return nil
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
