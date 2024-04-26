CREATE DATABASE iqj;


-- Создание таблицы новостей (news)
CREATE TABLE IF NOT EXISTS news (
    news_id SERIAL PRIMARY KEY,
    header TEXT NOT NULL,
    link TEXT NOT NULL,
    news_text TEXT NOT NULL,
    image_links TEXT[],
    tags VARCHAR(255)[],
    publication_time TIMESTAMP
);

-- Создание таблицы пользователей (users)
CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password TEXT NOT NULL
);

-- Создание таблицы данных пользователей (users_data)
CREATE TABLE IF NOT EXISTS users_data (
    user_data_id INT PRIMARY KEY REFERENCES users(user_id),
    user_name VARCHAR(255) NOT NULL,
    biography TEXT NOT NULL,
    useful_data TEXT NOT NULL,
    role VARCHAR(50) NOT NULL
);

-- Создание таблицы студентов (students)
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY REFERENCES users(user_id),
    student_group_id INT NOT NULL,
    student_teachers_ids INT[]
);

-- Создание таблицы преподавателей (teachers)
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INT PRIMARY KEY REFERENCES users(user_id),
    teachers_students_groups_ids INT[]
);

-- Создание таблицы студенческих групп (student_groups)
CREATE TABLE IF NOT EXISTS student_groups (
    students_group_id SERIAL PRIMARY KEY,
    grade INT NOT NULL,
    institute VARCHAR(128) NOT NULL,
    student_group_name VARCHAR(11) NOT NULL,
    student_group_students_ids INT[]
);

-- Создание таблицы расписания (schedule)
CREATE TABLE IF NOT EXISTS classes (
    class_id SERIAL PRIMARY KEY,
    class_group_ids INT[] NOT NULL,
    class_teacher_id INT NOT NULL,
    count INT NOT NULL,
    weekday INT NOT NULL,
    week INT NOT NULL,
    class_name VARCHAR(255),
    class_type VARCHAR(30),
    class_location VARCHAR(40) NOT NULL
);

-- Создание таблицы объявлений (ad)
CREATE TABLE IF NOT EXISTS advertisements (
    advertiesment_id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    creation_date TIMESTAMP,
    expiration_date TIMESTAMP
);

CREATE USER iqj_admin WITH PASSWORD 'aZCF131';
GRANT ALL PRIVILEGES ON DATABASE iqj TO iqj_admin;
