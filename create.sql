CREATE TYPE zone_ AS ENUM ('Зеленая зона', 'Желтая зона', 'Красная зона', 'Эпицентр');
CREATE TYPE mets_ AS ENUM ('Осколок', 'Ариадна', 'Банка', 'Грелка', 'Дозиметр', 'Живая Вода', 'Жук', 'Зеленка', 'Компас', 'Медсестра', 'Невидимка', 'Отмычка', 'Пиявка', 'Пластырь', 'Примус', 'Пустышка', 'Родник', 'Светлячок', 'Старатель', 'Тишь', 'Филин', 'Шестое чувство', 'Энерджайзер', 'Адреналин');
CREATE TYPE anomaly_ AS ENUM ('Воронка', 'Газовая Аномалия', 'Грава', 'Жаровня', 'Жернова', 'Зыбь', 'Лизун', 'Магнит', 'Миротворец', 'Мясорубка', 'Оковы', 'Паутина', 'Плешь', 'Пух', 'Пушка', 'Раздиратель', 'Рулетка', 'Свечение', 'Сито', 'Соленоид', 'Студень', 'Туча', 'Центрифуга');
CREATE TYPE rank_ AS ENUM ('рядовой', 'ефрейтор', 'младший сержант', 'сержант', 'старший сержант', 'старшина', 'прапорщик','старший прапорщик', 'младший лейтенант', 'лейтенант', 'старший лейтенант', 'капитан', 'майор','подполковник', 'полковник', 'генерал-майор', 'генерал-лейтенант', 'генерал-полковник');
CREATE TYPE size_ AS ENUM ('большая', 'средняя', 'маленькая', 'крохотная');

CREATE TABLE Human
(
	ID SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	age INTEGER NOT NULL
);

CREATE TABLE Operative
(
	ID SERIAL PRIMARY KEY,
	call_sign TEXT NOT NULL,
	specialization TEXT NOT NULL,
	grade rank_ NOT NULL,
	id_human INTEGER REFERENCES Human
);

CREATE TABLE Location
(
	ID SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	zone zone_  NOT NULL,
	widht NUMERIC(7,5) NOT NULL,
	longitude NUMERIC(7,5) NOT NULL
);

CREATE TABLE Brigade
(
	ID SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	id_location INTEGER REFERENCES Location
);

CREATE TABLE Citizen
(
	ID SERIAL PRIMARY KEY,
	call_sigh TEXT NOT NULL,
	id_brigade INTEGER REFERENCES Brigade,
	id_human INTEGER REFERENCES Human
);

CREATE TABLE Anomaly
(
	ID SERIAL PRIMARY KEY,
	name anomaly_ NOT NULL,
	zone zone_ NOT NULL,
	widht NUMERIC(7,5) NOT NULL,
	longitude NUMERIC(7,5) NOT NULL,
	id_location INTEGER REFERENCES Location,
	id_operative INTEGER REFERENCES Operative,
	size size_ NOT NULL
);

CREATE TABLE Equipment
(
	ID SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	description TEXT NOT NULL,
	id_operative INTEGER REFERENCES Operative
);

CREATE TABLE Owners_eqp
(
	id_equipment INTEGER REFERENCES Equipment,
	id_operative INTEGER REFERENCES Operative
);

CREATE TABLE Operation
(
	ID SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	date TIMESTAMP NOT NULL,
	id_location INTEGER REFERENCES Location
);

CREATE TABLE Squad
(	
	id_operative INTEGER REFERENCES Operative,
	id_commander INTEGER REFERENCES Operative
); 

CREATE TABLE Metamorphite
(
	ID SERIAL PRIMARY KEY,
	id_location INTEGER REFERENCES Location,
	id_operative INTEGER REFERENCES Operative,
	name mets_ NOT NULL,
	zone zone_ NOT NULL,
	widht NUMERIC(7,5) NOT NULL,
	longitude NUMERIC(7,5) NOT NULL
);

CREATE TABLE Owners_met
(
	id_operative INTEGER REFERENCES Operative,
	id_metamorphite INTEGER REFERENCES Metamorphite
);

CREATE TABLE Kill
(	
	ID SERIAL PRIMARY KEY,
	id_citizen INTEGER REFERENCES Citizen,
	id_operative INTEGER REFERENCES Operative,
	name BOOLEAN NOT NULL
);

CREATE TABLE Captive
(	
	ID SERIAL PRIMARY KEY,
	id_citizen INTEGER REFERENCES Citizen,
	id_operative INTEGER REFERENCES Operative,
	name BOOLEAN NOT NULL
);