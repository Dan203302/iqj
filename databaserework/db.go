package databaserework

import (
	"database/sql"
	"fmt"
	"iqj/config"
	"sync"
)

// Переменная (объект базы данных) используемая для доступа к её зависимостям(хендлерам конкретных таблиц)
var Database2 database123

// Структура, реализующая двухуровневое внедрение зависимостей, для более удобного доступа и управления базой данных
type database123 struct {
	Users *usersTable
	News  *newsTable
}

// Интерфейс структур, отвечающий за доступ к базе данных (по большей части сделан для написания тестов)
type TableModel interface {
	Add(entity) error
	Get(entity) ([]entity, error)
	new(*sql.DB, *sync.Mutex)
}

/*
Интерфейс, включающий в себя все структуры сущностей, используемых в базе данных.
(прим. User,Lesson,News,Student)
*/
type entity interface {
	isDefault() bool
}

/*
NewDatabaseInstance() создает новое подключение к базе данных, не возвращает ошибку,
если подключение создать не удалось, чтобы не захламлять main(), вызывает панику
при ошибке.
*/
func NewDatabaseInstance() {

	// iqj/config/config.go, дальше думаю разберетесь
	connectionString := fmt.Sprintf(
		"host=%v port=%v user=%v password=%v dbname=%v sslmode=disable",
		config.DbData["host"],
		config.DbData["port"],
		config.DbData["user"],
		config.DbData["password"],
		config.DbData["database"])

	// подключает приложение к базе данных, инициализирует и подгатавливает
	// зависимости (даже создает таблицы)
	err := Database2.connectDatabase(connectionString)

	if err != nil {
		// если че то пошло не так, то дает пизды всей программе, ибо че вы
		// там с подключением накосячили дурачки, совсем с ума посходили?
		panic(err)
	}
}

// Подключает базу данных используя connectionString, а также sql.Open(), также раздает зависимостям доступ к базе данных.
func (st *database123) connectDatabase(connectionString string) error {

	db, err := sql.Open("postgres", connectionString)

	if err != nil {
		//
		return fmt.Errorf("could not connect to the database: %v", err)
	}

	// создаем единый мьтекс, т.к. все таки подключение у нас одно
	// хотя малое да удалое, но все равно, мне пока слишком в падлу
	// делать множества подключений, а открывать новые для каждой операции
	// уже как-то не IdIoMaTiC Go))) довольствуйтесь тем что имеете
	mutex := &sync.Mutex{}

	// Раздаем зависимости (подключение к БД) для функций доступа к отдельным таблицам
	st.connectTables(db, mutex)

	err = db.Ping()
	if err != nil {
		return fmt.Errorf("could not ping the database: %v", err)
	}

	// возвращаем nil вместо ошибки если все хорошо и никто не потерял конфиги
	// спасибо люблю вас чмоки чмоки 😇😇😇
	return nil
}

func (st *database123) connectTables(db *sql.DB, mutex *sync.Mutex) {
	// я бездарь поэтому просто захардкодил, я реально не знаю че тут еще можно сделать
	// послушаю ваше предложение за сто рублей, обращаться в тг, думаю найдете
	st.Users.new(db, mutex)
	st.News.new(db, mutex)
}
