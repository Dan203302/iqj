package database

import (
	"database/sql"
	"fmt"
	"iqj/config"
)

// Переменная (объект базы данных) используемая для доступа к её зависимостям(хендлерам конкретных таблиц)
var Database DatabaseRepository

// Структура, реализующая двухуровневое внедрение зависимостей, для более удобного доступа и управления базой данных
type DatabaseRepository struct {
	User          *UserTable
	UserData      *UserDataTable
	News          *NewsTable
	Student       *StudentTable
	StudentGroup  *StudentGroupTable
	Class         *ClassTable
	Advertisement *AdvertisementTable
	Teacher       *TeacherTable
}

// Интерфейс структур, отвечающий за доступ к базе данных (по большей части сделан для написания тестов)
type TableModel interface {
	Add(*Entity) error
	GetById(*Entity) (*Entity, error)
}

/*
Интерфейс, включающий в себя все структуры сущностей, используемых в базе данных.
(прим. User,Lesson,News,Student)
*/
type Entity interface {
	isDefault() bool
}

type Interactor interface {
	makeDelete(*sql.DB, string, ...interface{}) error
	makeInsert(*sql.DB, string, ...interface{}) error
	makeSelect(*sql.DB, string, ...interface{}) (*sql.Rows, error)
}

// NewDatabaseInstance() создает новое подключение к базе данных, не возвращает ошибку,
// если подключение создать не удалось, чтобы не захламлять main(), вызывает панику
// при ошибке.
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
	err := Database.connectDatabase(connectionString)

	if err != nil {
		// если че то пошло не так, то дает пизды всей программе, ибо че вы
		// там с подключением накосячили дурачки, совсем с ума посходили?
		panic(err)
	}
}

// Подключает базу данных используя connectionString, а также sql.Open(), раздает зависимостям доступ к базе данных.
func (st *DatabaseRepository) connectDatabase(connectionString string) error {

	db, err := sql.Open("postgres", connectionString)

	if err != nil {
		//
		return fmt.Errorf("could not connect to the database: %v", err)
	}

	// создаем единый мьтекс, т.к. все таки подключение у нас одно
	// хотя малое да удалое, но все равно, мне пока слишком в падлу
	// делать множества подключений, а открывать новые для каждой операции
	// уже как-то не IdIoMaTiC Go))) довольствуйтесь тем что имеете
	// mutex := &sync.Mutex{}

	err = db.Ping()
	if err != nil {
		return fmt.Errorf("could not ping the database: %v", err)
	}

	st.connectTables(db)

	// возвращаем nil вместо ошибки если все хорошо и никто не потерял конфиги
	// спасибо люблю вас чмоки чмоки 😇😇😇
	return nil
}

// раздаем указатели на подключение декораторам
func (st *DatabaseRepository) connectTables(db *sql.DB) {
	st.User = &UserTable{
		db: db,
		tm: transactionMaker{},
	}
	st.UserData = &UserDataTable{
		db: db,
		tm: transactionMaker{},
	}
	st.News = &NewsTable{
		db: db,
		qm: queryMaker{},
	}
	st.Student = &StudentTable{
		db: db,
		qm: queryMaker{},
	}
	st.StudentGroup = &StudentGroupTable{
		db: db,
		qm: queryMaker{},
	}
	st.Class = &ClassTable{
		db: db,
		qm: queryMaker{},
	}
	st.Advertisement = &AdvertisementTable{
		db: db,
		qm: queryMaker{},
	}
	st.Teacher = &TeacherTable{
		db: db,
		qm: queryMaker{},
	}
}
