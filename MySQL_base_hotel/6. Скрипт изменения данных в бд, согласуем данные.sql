-- Вносим корректировки в таблицу Пользователей
UPDATE users SET 
  updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at; 

-- Вносим корректировки в таблицу Броинрование номера
SELECT * FROM room_reservation ORDER BY numbers_id;

UPDATE room_reservation SET 
  departure_date = DATE_ADD(arrival_date, INTERVAL RAND()*14 DAY);

 -- Вносим корректировки в таблицу Отзывов на отели
SELECT * FROM reviews LIMIT 10;

UPDATE reviews SET
  arrival_date = ADDDATE(DATE'2019-01-01', RAND()*450),
  departure_date =  DATE_ADD(arrival_date, INTERVAL RAND()*7 DAY),
  rating = ROUND(RAND()*10, 2); 
 
UPDATE reviews SET
  created_at = DATE_ADD(departure_date, INTERVAL FLOOR(RAND()*24) DAY_HOUR);

-- Вносим корректоровки в таблицу Номера
SELECT * FROM numbers;

UPDATE numbers SET
  cost = FLOOR(RAND()*5000);

-- Вносим корректировки в таблицу Уведомления
SELECT * FROM notifications LIMIT 150;

UPDATE notifications SET
  created_at = ADDDATE(DATE'2018-01-01', INTERVAL FLOOR(RAND()*24) DAY_HOUR);

-- Вносим корректировки в таблицу сообщения
UPDATE messages SET 
  created_at = ADDDATE(DATE'2018-05-04', INTERVAL FLOOR(RAND()*24) DAY_HOUR);

-- Вносим корректировки в таблицу Отели
UPDATE hotel SET 
  rating = ROUND(RAND()*10, 2);
UPDATE hotel SET
  numbers_id = FLOOR(1+ RAND()*20),
  services_type_id = FLOOR(1+ RAND()*10);

-- Вносим корректировки в таблицу Кредитные карты
UPDATE credit_card SET
  number_card = FLOOR(RAND()*999999999999999),
  card_end_date = ADDDATE(DATE'2019-01-01', RAND()*1095);

-- Вносим корректировки в таблицу Совершенные броинрования
UPDATE completed_reservations SET
  arrival_date = ADDDATE(DATE'2019-01-01', RAND()*450),
  departure_date =  DATE_ADD(arrival_date, INTERVAL FLOOR(1 + RAND()*7) DAY),
  cost = FLOOR(RAND()*5000); 

