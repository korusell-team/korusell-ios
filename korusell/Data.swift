//
//  Data.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import Foundation

let fakeUser = Contact(name: "Сергей", surname: "Ли", image: "sergey-lee", categories: ["IT"], tags: ["💻Программирование", "📱Приложения", "🍏iOS"], bio: "\niOS")



let listOfCategories: [Category] = [
    Category(name: "Дизайн", image: "✏️", tags: ["📱UI/UX", "🌐Web", "✏️Графический дизайн"]),
    Category(name: "IT", image: "🖥️", tags: ["💻Программирование", "📱Приложения", "🍏iOS", "🤖Android", "🌐Сайты"]),
    Category(name: "Образование", image: "🎓", tags: ["🛂Смена-Визы", "🇰🇷Корейский язык", "✏️Дизайн", "💻Программирование", "🧑🏻‍🏫Школа", "🚙Автошкола"]),
    Category(name: "Мероприятия", image: "🎉", tags: ["🦸🏻‍♂️Ведущий", "🤵🏻‍♂️Тамада", "🎤Вокалист", "🧑‍🎤Певец", "🌷Цветы"]),
    Category(name: "Фото-Видео", image: "📷", tags: ["🎥Видеограф", "📷Фотограф", "🎉Праздник", "🎁Мероприятия"]),
    Category(name: "Маркетинг", image: "📈", tags: ["💸Продажи", "📢Продвижение", "💭SMM"]),
    Category(name: "Переводы", image: "💬", tags: ["💬Переводчик", "🇰🇷Корейский", "🇬🇧Английский"]),
    Category(name: "Здоровье-Красота", image: "🏥", tags: ["🦷Стоматология", "💄Косметика", "㆞Тату", "💇🏻Парикмахер", "👧🏻Визажист", "💅🏼Маникюр", "🦶Педикюр", "👁️Ресницы", "👨🏻‍⚕️Пластическая хирургия", "👩‍⚕️Гинекология"]),
    Category(name: "Транспорт", image: "🛞", tags: ["🚚Перевозки", "🚗Купля-Продажа", "🚢Экспорт", "⚙️СТО", "🏎️Тюнинг", "⚡️Электрик"]),
    Category(name: "Ремонт", image: "🛠️", tags: ["🎧Электроника", "🏠Квартиры", "🛁Сантехник", "⚡️Электрик"]),
]


let listOfContacts: [Contact] = [
    Contact(name: "Евгений", surname: "Ким", image: "evgeniy-hvan", categories: ["Мероприятия"], tags: ["🦸🏻‍♂️Ведущий", "🤵🏻‍♂️Тамада"], phone: "01012341234", instagram: "https://instagram.com/vlog.vedushego?igshid=OGQ5ZDc2ODk2ZA==", bio: "Лучший Ведущий мероприятий\nв Южной Корее!"),
    Contact(name: "Сергей", surname: "Ли", image: "sergey-lee", categories: ["IT"], tags: ["💻Программирование", "📱Приложения", "🍏iOS"], bio: "\niOS"),
    Contact(name: "Антон", surname: "Емельянов", categories: ["IT"], tags: ["💻Программирование", "🌐Сайты"], bio: "fullstack\ndeveloper"),
    Contact(name: "Андрей", surname: "Ким", bio: "я просто рандомный чел...🤪"),
    Contact(name: "Владимир", surname: "Мун", cities: ["Сеул"], image: "vladimir-mun", categories: ["Образование"], tags: ["✏️Дизайн", "💻Программирование"], phone: "010-1234-1234", instagram: "https://www.instagram.com/reel/Co3-k56D537/?utm_source=ig_web_copy_link&igshid=MzRlODBiNWFlZA==", link: "https://habsida.com/ru", youtube: "https://www.youtube.com/watch?v=AMS7GqqQhdc&t=8s", bio: "Habsida. Школа программирования и дизайна. С оплатой после трудоустройства!"),
    Contact(name: "Владимир", surname: "Тен", image: "vladimir-ten", categories: ["Образование"], tags: ["🇰🇷Корейский язык"], phone: "01012341234", instagram: "https://instagram.com/vladimirten?igshid=OGQ5ZDc2ODk2ZA==", bio: "Основатель школы корейского языка 'Korean Simple' и далее длинное описание услуг которые может предоставить данный человек"),
    Contact(name: "David", surname: "Beckham", image: "david-beckham", likes: ["k0jihero"], marks: ["k0jihero"], instagram: "https://www.instagram.com/davidbeckham", bio: "I'm here to check if english content displays properly"),
]

let listOfPlaces: [Place] = [
    Place(name: "Кафе Виктория", tags: ["мероприятия", "праздники", "свадьбы", "асянди", "хангаби"]),
    Place(name: "Habsida", tags: ["Образование", "IT", "программирование", "обучение"]),
    Place(name: "СТО", tags: ["транспорт", "ремонт"]),
]



//let listOfCategories: [Category] = [
//    Category(name: "Дизайн", image: "design", tags: ["UI/UX", "Web", "Графика"]),
//    Category(name: "IT", image: "IT", tags: ["Программирование", "Приложения", "Сайты", "Web"]),
//    Category(name: "Фото-Видео", image: "photo", tags: ["Видеограф", "Фотограф", "Праздник", "Мероприятия"]),
//    Category(name: "Маркетинг", image: "marketing", tags: ["Продажи", "Продвижение", "SMM"]),
//    Category(name: "Переводы", image: "translate", tags: ["Переводчик", "Корейский", "Английский"]),
//    Category(name: "Здоровье-Красота", image: "health", tags: ["Стоматология", "Косметика", "Тату", "Парикмахер", "Визажист", "Маникюр", "Педикюр", "Ресницы", "Пластическая хирургия", "Гинекология"]),
//    Category(name: "Транспорт", image: "transport", tags: ["Перевозки", "Груз", "Купля-Продажа", "Экспорт", "СТО", "Тюнинг", "Электрик"]),
//    Category(name: "Образование", image: "education", tags: ["Смена-Визы", "Корейский язык", "Дизайн", "Программирование", "Школа", "Автошкола"]),
//    Category(name: "Ремонт", image: "repair", tags: ["Электроника", "Квартиры", "Сантехник", "Электрик"]),
//    Category(name: "Мероприятия", image: "event", tags: ["Ведущий", "Тамада", "Вокалист", "Певец", "Цветы"])
//]

// MARK: reserve
//let listOfCategories: [Category] = [
//    Category(name: "Дизайн", image: "design", tags: ["Дизайн", "UI/UX", "Web", "Графика"]),
//    Category(name: "IT", image: "IT", tags: ["IT", "программирование", "приложения", "сайты", "web"]),
//    Category(name: "Фото-Видео", image: "photo", tags: ["видео", "фото", "праздник", "мероприятия"]),
//    Category(name: "Маркетинг", image: "marketing", tags: ["маркетинг", "продажи", "продвижение", "СММ", "SMM", "marketing"]),
//    Category(name: "Переводы", image: "translate", tags: ["translate", "переводы", "переводчик", "корейский", "английский"]),
//    Category(name: "Здоровье-Красота", image: "health", tags: ["здоровье", "красота", "стоматология", "косметика", "тату", "парикмахер", "визажист", "маникюр", "педикюр", "зубной", "ресницы", "пластика", "гинекология"]),
//    Category(name: "Транспорт", image: "transport", tags: ["transport", "транспорт", "перевозки", "груз", "автомобиль", "купля", "продажа", "экспорт", "СТО", "ремонт", "тюнинг"]),
//    Category(name: "Образование", image: "education", tags: ["образование", "смена", "виза", "корейский", "язык", "дизайн", "программирование", "курсы"]),
//    Category(name: "Ремонт", image: "repair", tags: ["ремонт", "электроника", "техника", "дом", "квартиры", "помещение", "сантехника", "электрика"]),
//    Category(name: "Мероприятия", image: "event", tags: ["праздник", "мероприятия", "ведущий", "тамада", "вокалист", "певец"])
//]

/*
 Contacts categories:
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
