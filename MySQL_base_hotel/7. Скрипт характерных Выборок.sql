-- ������, ��� ���������� ������� ����.

SELECT CONCAT(users.first_name, ' ',  users.last_name) AS fullname FROM users
  INNER JOIN public_profiles ON public_profiles.user_id = users.id
    WHERE public_profiles.language_id = 11;

-- ������ �������������, ������� ������������ ������� � ������ � ������������ �� �������
   
SELECT CONCAT(users.first_name, ' ',  users.last_name) AS fullname FROM users 
  GROUP BY smoking_in_the_room = TRUE AND business_traveler = TRUE;
  
-- ��������� ������ ������� ����� �����, ��������� ����� ���� �����, ������ ����� ������� � ����� �������
 
SELECT * FROM services_type;

SELECT sum(cost) AS sum_cost, min(cost) AS min_cost, max(cost) AS max_cost FROM services_type;

-- ��������� ������� ����� ����� � ������ ��������������� ������ �� ����� ������ ������ �������������

SELECT numbers.cost AS numb_cost, services_type.cost AS st_cost FROM hotel 
  INNER JOIN numbers ON hotel.numbers_id = numbers.id
  RIGHT JOIN services_type ON hotel.services_type_id = services_type.id 
  WHERE hotel.id = 1;
  
-- �������� ����������� ������������ ������������� � ���� ������

(SELECT hotel_id FROM completed_reservations WHERE user_id = 15)
UNION
(SELECT user_id FROM completed_reservations WHERE hotel_id = 15);

-- ���������, ��� ������ �������� ������������ ������� ��� �������

SELECT
  (SELECT gender FROM users WHERE id = completed_reservations.user_id) AS gender,
  COUNT(*) AS total
  FROM completed_reservations
  GROUP BY gender
  ORDER BY total DESC
  LIMIT 1;
    
-- ���������� ���������� �������, ������� �������� 10 ����� ������� �������������
SELECT COUNT(*) FROM reviews 
  WHERE rating > 7.00
    AND hotel_id IN (SELECT * FROM (
      SELECT user_id FROM public_profiles ORDER BY birthday DESC LIMIT 10
    ) AS sorted_profiles ) 
;

-- ������� ������ �� ������������
SELECT first_name, last_name, email, phone, gender, birthday, city, country, languages.name AS Languages_users, currency.name AS currency 
  FROM users
    INNER JOIN public_profiles ON users.id = public_profiles.user_id
    INNER JOIN languages ON public_profiles.language_id = languages.id
    INNER JOIN currency ON public_profiles.currency_id = currency.id
  WHERE users.id = 55;

-- C�������� �� ������������ � ����� � �� ����� ������������
SELECT messages.from_user_id, messages.from_hotel_id, messages.body, messages.created_at
  FROM users
    JOIN messages
      ON users.id = messages.from_user_id
        OR users.id = messages.from_hotel_id
  WHERE users.id = 34;