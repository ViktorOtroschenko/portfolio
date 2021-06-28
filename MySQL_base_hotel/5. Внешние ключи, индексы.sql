-- Внешние ключи 


ALTER TABLE public_profiles 
  ADD CONSTRAINT public_profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT public_profiles_language_id_fk
    FOREIGN KEY (language_id) REFERENCES languages(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT public_profiles_currency_id_fk
    FOREIGN KEY (currency_id) REFERENCES currency(id)
      ON DELETE CASCADE;

ALTER TABLE notifications
  ADD CONSTRAINT notifications_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;

ALTER TABLE credit_card 
  ADD CONSTRAINT credit_card_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
ALTER TABLE completed_reservations 
  ADD CONSTRAINT completed_reservations_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT completed_reservations_hotel_id_fk
    FOREIGN KEY (hotel_id) REFERENCES hotel(id)
      ON DELETE CASCADE;

ALTER TABLE room_reservation 
  ADD CONSTRAINT room_reservation_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT room_reservation_numbers_id_fk
    FOREIGN KEY (numbers_id) REFERENCES numbers(id)
      ON DELETE CASCADE;

ALTER TABLE reviews 
  ADD CONSTRAINT reviews_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT reviews_hotel_id_fk
    FOREIGN KEY (hotel_id) REFERENCES hotel(id)
     ON DELETE CASCADE;
         
ALTER TABLE hotel 
  ADD CONSTRAINT hotel_numbers_id_fk
    FOREIGN KEY (numbers_id) REFERENCES numbers(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT hotel_services_type_id_fk
    FOREIGN KEY (services_type_id) REFERENCES services_type(id)
      ON DELETE CASCADE;
    
ALTER TABLE messages 
  ADD CONSTRAINT messages_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT messages_from_hotel_id_fk
    FOREIGN KEY (from_hotel_id) REFERENCES hotel(id)
      ON DELETE CASCADE;

-- Индексы

CREATE INDEX users_first_name_last_name_idx ON users(first_name, last_name);

CREATE INDEX users_phone_idx ON users(phone);
     
CREATE INDEX users_email_idx ON users(email);

CREATE INDEX public_profiles_birthday_idx ON public_profiles(birthday);

CREATE INDEX public_profiles_city_idx ON public_profiles(city);

CREATE INDEX public_profiles_country_idx ON public_profiles(country);

CREATE INDEX credit_card_number_card_idx ON credit_card(number_card);

CREATE INDEX room_resrvation_user_id_numbers_id_idx ON room_reservation(user_id, numbers_id);

CREATE INDEX messages_from_user_id_from_hotel_id_idx ON messages(from_user_id, from_hotel_id);

CREATE INDEX reviews_user_id_hotel_id_idx ON reviews(user_id, hotel_id);

CREATE INDEX hotel_name_idx ON hotel(name);

CREATE INDEX completed_reservations_user_id_hotel_id_idx ON completed_reservations(user_id, hotel_id);


