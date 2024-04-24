CREATE DATABASE iqj;


-- Создание таблицы новостей (news)
CREATE TABLE IF NOT EXISTS News (
    NewsId SERIAL PRIMARY KEY,
    Header TEXT NOT NULL,
    Link TEXT NOT NULL,
    NewsText TEXT NOT NULL,
    ImageLinks TEXT[],
    Tags VARCHAR(255)[],
    PublicationTime TIMESTAMP
);

-- Создание таблицы пользователей (users)
CREATE TABLE IF NOT EXISTS Users (
    UserId SERIAL PRIMARY KEY,
    Email VARCHAR(255) NOT NULL,
    Password TEXT NOT NULL
);

-- Создание таблицы данных пользователей (users_data)
CREATE TABLE IF NOT EXISTS UsersData (
    UserDataId INT PRIMARY KEY REFERENCES Users(UserId),
    UserName VARCHAR(255) NOT NULL,
    Biography TEXT NOT NULL,
    UsefulData TEXT NOT NULL,
    Role VARCHAR(50) NOT NULL
);

-- Создание таблицы студентов (students)
CREATE TABLE IF NOT EXISTS Students (
    StudentId INT PRIMARY KEY REFERENCES Users(UserId),
    StudentGroupId INT NOT NULL,
    StudentTeachersIds INT[]
);

-- Создание таблицы преподавателей (teachers)
CREATE TABLE IF NOT EXISTS Teachers (
    TeacherId INT PRIMARY KEY REFERENCES Users(UserId),
    TeachersStudentsGroupsIds INT[]
);

-- Создание таблицы студенческих групп (student_groups)
CREATE TABLE IF NOT EXISTS StudentsGroups (
    StudentsGroupId SERIAL PRIMARY KEY,
    Grade INT NOT NULL,
    Institute VARCHAR(128) NOT NULL,
    StudentGroupName VARCHAR(11) NOT NULL,
    StudentGroupStudentsIds INT[]
);

-- Создание таблицы расписания (schedule)
CREATE TABLE IF NOT EXISTS Classes (
    ClassId SERIAL PRIMARY KEY,
    ClassGroupIds INT[] NOT NULL,
    ClassTeacherId INT NOT NULL,
    Count INT NOT NULL,
    Weekday INT NOT NULL,
    Week INT NOT NULL,
    ClassName VARCHAR(255),
    ClassType VARCHAR(30),
    ClassLocation VARCHAR(40) NOT NULL
);

-- Создание таблицы объявлений (ad)
CREATE TABLE IF NOT EXISTS Advertisements (
    AdvertiesmentId SERIAL PRIMARY KEY,
    Content TEXT NOT NULL
);

CREATE USER iqj_admin WITH PASSWORD 'aZCF131';
GRANT ALL PRIVILEGES ON DATABASE iqj TO iqj_admin,root;
