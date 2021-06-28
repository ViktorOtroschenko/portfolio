-- Представления

-- Выводим полную информацию о пользователях по алфавиту

CREATE OR REPLACE VIEW users_inf (fullname, phone, gender, email, birthday, city, country) 
AS SELECT CONCAT(users.first_name, ' ', users.last_name), users.phone, users.gender, users.email, public_profiles.birthday, public_profiles.city, public_profiles.country 
FROM users 
LEFT JOIN public_profiles ON users.id = public_profiles.user_id ORDER BY CONCAT(users.first_name, ' ', users.last_name);

SELECT * FROM users_inf;

-- Смотрим отзывы с оценками пользователей на отели

CREATE OR REPLACE VIEW users_reviews (fullname, hotel_name, rating, reviews) 
AS SELECT CONCAT(users.first_name, ' ', users.last_name), hotel.name, reviews.rating, reviews.reviews
FROM users 
INNER JOIN reviews ON users.id = reviews.user_id 
LEFT JOIN hotel ON reviews.hotel_id = hotel.id;

SELECT * FROM users_reviews;

-- Выводим информацию на отель, и предоставляемую услугу с ценой

CREATE OR REPLACE VIEW hotel_services (name, services, cost, rating)
AS SELECT hotel.name, services_type.name, services_type.cost, hotel.rating
FROM hotel
INNER JOIN services_type ON hotel.services_type_id = services_type.id;

SELECT * FROM hotel_services;


-- Хранимые процедуры / триггеры

-- Создадим таблицу с логами, в которую будут вносится время и дата регистрации нового пользователя, отеля и номера.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  created_at DATETIME NOT NULL,
  table_name VARCHAR(64) NOT NULL,
  id_pk BIGINT(32) NOT NULL,
  value_name VARCHAR(64) NOT NULL
  ) ENGINE = ARCHIVE;
  
DROP TRIGGER IF EXISTS watchlog_users;
delimiter //
CREATE TRIGGER watchlog_users AFTER INSERT ON users
  FOR EACH ROW
  BEGIN
    INSERT INTO logs (created_at, table_name, id_pk, value_name)
    VALUES (NOW(), 'users', NEW.id, NEW.first_name, NEW.last_name);
  END //
delimiter ;

DROP TRIGGER IF EXISTS watchlog_hotel;
delimiter //
CREATE TRIGGER watchlog_hotel AFTER INSERT ON hotel
  FOR EACH ROW
  BEGIN
    INSERT INTO logs (created_at, table_name, id_pk, value_name)
    VALUES (NOW(), 'hotel', NEW.id, NEW.name);
  END //
delimiter ;

DROP TRIGGER IF EXISTS watchlog_numbers;
delimiter //
CREATE TRIGGER watchlog_catalogs AFTER INSERT ON numbers
  FOR EACH ROW
  BEGIN
    INSERT INTO logs (created_at, table_name, id_pk, value_name)
    VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
  END //
delimiter ;

INSERT INTO `numbers` (`name`, `bed`, `description`, `seats_in_the_room`, `cost`) VALUES ('Люкс', '1 двухспальная кровать', 'Размер номера  40 м?', 2, 4550);

SELECT * FROM logs;
