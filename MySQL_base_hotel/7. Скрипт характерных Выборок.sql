-- Ќайдем, кто использует русский €зык.

SELECT CONCAT(users.first_name, ' ',  users.last_name) AS fullname FROM users
  INNER JOIN public_profiles ON public_profiles.user_id = users.id
    WHERE public_profiles.language_id = 11;

-- Ќайдем пользователей, которые предпочитает курение в номере и путешествуют по бизнесу
   
SELECT CONCAT(users.first_name, ' ',  users.last_name) AS fullname FROM users 
  GROUP BY smoking_in_the_room = TRUE AND business_traveler = TRUE;
  
-- ѕосмотрим список платных услуг отел€, посчитаем сумму всех услуг, найдем самую дешевую и самую дорогую
 
SELECT * FROM services_type;

SELECT sum(cost) AS sum_cost, min(cost) AS min_cost, max(cost) AS max_cost FROM services_type;

-- ѕосмотрим сколько стоит номер и услуга предоставл€ема€ отелем во врем€ поиска отелей пользователем

SELECT numbers.cost AS numb_cost, services_type.cost AS st_cost FROM hotel 
  INNER JOIN numbers ON hotel.numbers_id = numbers.id
  RIGHT JOIN services_type ON hotel.services_type_id = services_type.id 
  WHERE hotel.id = 1;
  
-- ¬ыбираем совершенные бронировани€ пользователем с двух сторон

(SELECT hotel_id FROM completed_reservations WHERE user_id = 15)
UNION
(SELECT user_id FROM completed_reservations WHERE hotel_id = 15);

-- ѕосчитаем, кто больше совершил бронировани€ мужчины или женщины

SELECT
  (SELECT gender FROM users WHERE id = completed_reservations.user_id) AS gender,
  COUNT(*) AS total
  FROM completed_reservations
  GROUP BY gender
  ORDER BY total DESC
  LIMIT 1;
    
-- ѕодсчитаем количество отзывов, которые написали 10 самых молодых пользователей
SELECT COUNT(*) FROM reviews 
  WHERE rating > 7.00
    AND hotel_id IN (SELECT * FROM (
      SELECT user_id FROM public_profiles ORDER BY birthday DESC LIMIT 10
    ) AS sorted_profiles ) 
;

-- ¬ыборка данных по пользователю
SELECT first_name, last_name, email, phone, gender, birthday, city, country, languages.name AS Languages_users, currency.name AS currency 
  FROM users
    INNER JOIN public_profiles ON users.id = public_profiles.user_id
    INNER JOIN languages ON public_profiles.language_id = languages.id
    INNER JOIN currency ON public_profiles.currency_id = currency.id
  WHERE users.id = 55;

-- Cообщени€ от пользовател€ к отелю и от отел€ пользователю
SELECT messages.from_user_id, messages.from_hotel_id, messages.body, messages.created_at
  FROM users
    JOIN messages
      ON users.id = messages.from_user_id
        OR users.id = messages.from_hotel_id
  WHERE users.id = 34;