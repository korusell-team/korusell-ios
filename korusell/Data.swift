//
//  Data.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import Foundation

let fakeUser = Member(name: "Сергей", surname: "Ли")


let listOfMembers: [Member] = [
    Member(name: "Евгений", surname: "Ким", categories: [] tags: ["мероприятия", "ведущий", "праздники", "свадьбы", "асянди", "хангаби", "успешный успех", "тамада"], phone: "01012341234", instagram: "https://instagram.com/vlog.vedushego?igshid=OGQ5ZDc2ODk2ZA=="),
    Member(name: "Сергей", surname: "Ли", tags: ["IT", "программирование", "музыкант", "ios", "мобильные", "приложения"]),
    Member(name: "Антон", surname: "Емельянов", tags: ["IT", "программирование", "музыкант", "web", "сайты"]),
    Member(name: "Андрей", surname: "Ким"),
    Member(name: "Владимир", surname: "Мун", tags: ["Образование", "программирование", "Дизайн"]),
    Member(name: "Владимир", surname: "Тен", tags: ["Образование", "корейский"], phone: "01012341234", instagram: "https://instagram.com/vladimirten?igshid=OGQ5ZDc2ODk2ZA==", details: "Основатель школы корейского языка 'Korean Simple' и далее длинное описание услуг которые может предоставить данный человек"),
    Member(name: "David", surname: "Beckham", likes: ["k0jihero"], marks: ["k0jihero"], instagram: "https://instagram.com/koreathroughthelensofiphone?igshid=OGQ5ZDc2ODk2ZA==", details: "This is details information for David Beckham!")
]

let listOfPlaces: [Place] = [
    Place(name: "Кафе Виктория", tags: ["мероприятия", "праздники", "свадьбы", "асянди", "хангаби"]),
    Place(name: "Habsida", tags: ["Образование", "IT", "программирование", "обучение"]),
    Place(name: "СТО", tags: ["транспорт", "ремонт"]),
]



/*
 Members categories:
    IT/Дизайн
    Фото/Видео
    Маркетинг
    Переводы
    Ремонт
    Здоровье/Красота
    Транспорт
    Образование
    Трудоустройство
    Мероприятия/Подарки
    Страхование/Финансы
 
 
 
    Ремонт
        Электроника, Дом
    ? Телефоны
        Купля, Продажа, Связь, Аксессуары
    Образование
        Курсы, школа, смена визы,
    Мероприятия, Фото/Видео
        Ведущий, Певец, Фото, Видео, Цветы?
    Колеса
        Купля, Продажа, Экспорт, Перевозки, СТО, Тюнинг
    Здоровье/Красота
        Стоматология, Косметика, Тату, Салон красоты, Парикмахер, Маникюр, Педикюр, Ресницы, Пластика, Гинекология
    Страхование/Финансы
        Страхование, Кредитные карты,
    Туризм/Почта
        Авиакасса, Почта, Туризм
    Трудоустройство
    Перевод
 */
