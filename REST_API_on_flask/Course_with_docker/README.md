# python - flask - docker

Итоговый проект курса "Машинное обучение в бизнесе"

Стек:

ML: sklearn, pandas, numpy
API: flask
Данные с kaggle - https://www.kaggle.com/pinakimishrads/fake-news-classifier-data

Задача: предсказать по опубликовано тексту является ли он фейком или нет (поле label). Бинарная классификация

Используемые признаки:

- title
- text

Преобразования признаков: tfidf

Модель: GradientBoostingClassifier

### Клонируем репозиторий и создаем образ
```
$ git clone https://github.com/ViktorOtroschenko/ML_in_business.git
$ cd Course_with_docker
$ docker build -t gb_bml_docker .
```

### Запускаем контейнер
``` 
$ docker run -d -p 8180:8180 -p 8181:8181 gb_bml_docker 
```

### Переходим на localhost:8181