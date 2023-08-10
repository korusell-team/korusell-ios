//
//  Data.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import Foundation
import MapKit

let fakeUser = Contact(name: "Сергей", surname: "Ли", bio: "\niOS", image: "sergey-lee", categories: ["IT"], subcategories: ["💻Программирование", "📱Приложения", "🍏iOS"])



let listOfCategories: [Category] = [
    Category(name: "Дизайн", image: "✏️", subcategories: ["📱UI/UX", "🌐Web", "✏️Графический дизайн"]),
    Category(name: "IT", image: "🖥️", subcategories: ["💻Программирование", "📱Приложения", "🍏iOS", "🤖Android", "🌐Сайты"]),
    Category(name: "Образование", image: "🎓", subcategories: ["🛂Смена-Визы", "🇰🇷Корейский язык", "✏️Дизайн", "💻Программирование", "🧑🏻‍🏫Школа", "🚙Автошкола"]),
    Category(name: "Мероприятия", image: "🎉", subcategories: ["🦸🏻‍♂️Ведущий", "🤵🏻‍♂️Тамада", "🎤Вокалист", "🧑‍🎤Певец", "🌷Цветы"]),
    Category(name: "Фото-Видео", image: "📷", subcategories: ["🎥Видеограф", "📷Фотограф", "🎉Праздник", "🎁Мероприятия"]),
    Category(name: "Маркетинг", image: "📈", subcategories: ["💸Продажи", "📢Продвижение", "💭SMM"]),
    Category(name: "Переводы", image: "💬", subcategories: ["💬Переводчик", "🇰🇷Корейский", "🇬🇧Английский"]),
    Category(name: "Здоровье-Красота", image: "🏥", subcategories: ["🦷Стоматология", "💄Косметика", "㆞Тату", "💇🏻Парикмахер", "👧🏻Визажист", "💅🏼Маникюр", "🦶Педикюр", "👁️Ресницы", "👨🏻‍⚕️Пластическая хирургия", "👩‍⚕️Гинекология"]),
    Category(name: "Транспорт", image: "🛞", subcategories: ["🚚Перевозки", "🚗Купля-Продажа", "🚢Экспорт", "⚙️СТО", "🏎️Тюнинг", "⚡️Электрик"]),
    Category(name: "Ремонт", image: "🛠️", subcategories: ["🎧Электроника", "🏠Квартиры", "🛁Сантехник", "⚡️Электрик"]),
]


let listOfContacts: [Contact] = [
    Contact(name: "Евгений", surname: "Ким", bio: "Лучший Ведущий мероприятий\nв Южной Корее!", image: "evgeniy-hvan", categories: ["Мероприятия"], subcategories: ["🦸🏻‍♂️Ведущий", "🤵🏻‍♂️Тамада"], phone: "01012341234", instagram: "https://instagram.com/vlog.vedushego?igshid=OGQ5ZDc2ODk2ZA=="),
    Contact(name: "Сергей", surname: "Ли", bio: "\niOS", image: "sergey-lee", categories: ["IT"], subcategories: ["💻Программирование", "📱Приложения", "🍏iOS"]),
    Contact(name: "Антон", surname: "Емельянов", bio: "fullstack\ndeveloper", categories: ["IT"], subcategories: ["💻Программирование", "🌐Сайты"]),
    Contact(name: "Андрей", surname: "Ким", bio: "я просто рандомный чел...🤪"),
    Contact(name: "Владимир", surname: "Мун", bio: "Habsida. Школа программирования и дизайна. С оплатой после трудоустройства!", cities: ["Сеул"], image: "vladimir-mun", categories: ["Образование"], subcategories: ["✏️Дизайн", "💻Программирование"], phone: "010-1234-1234", instagram: "https://www.instagram.com/reel/Co3-k56D537/?utm_source=ig_web_copy_link&igshid=MzRlODBiNWFlZA==", youtube: "https://www.youtube.com/watch?v=AMS7GqqQhdc&t=8s", link: "https://habsida.com/ru"),
    Contact(name: "Владимир", surname: "Тен", bio: "Основатель школы корейского языка 'Korean Simple' и далее длинное описание услуг которые может предоставить данный человек", image: "vladimir-ten", categories: ["Образование"], subcategories: ["🇰🇷Корейский язык"], phone: "01012341234", instagram: "https://instagram.com/vladimirten?igshid=OGQ5ZDc2ODk2ZA=="),
    Contact(name: "David", surname: "Beckham", bio: "I'm here to check if english content displays properly", image: "david-beckham", instagram: "https://www.instagram.com/davidbeckham"),
]

let listOfPlaces: [Place] = [
    Place(name: "Кафе Виктория", subcategories: ["мероприятия", "праздники", "свадьбы", "асянди", "хангаби"], owner: "sad"),
    Place(name: "Habsida", subcategories: ["Образование", "IT", "программирование", "обучение"], owner: "sad"),
    Place(name: "СТО", subcategories: ["транспорт", "ремонт"], owner: "sad"),
]

var data: [PlacePoint] = [
    
    PlacePoint(type: .cafe, address: "서울%20영등포구%20여의도동%2084-1", coordinate: CLLocationCoordinate2D(latitude:  61.19533942,   longitude: -149.9054948 ), title: "У Тани", subtitle: "America"),
    PlacePoint(type: .cafe, coordinate: CLLocationCoordinate2D(latitude:  61.2297    ,   longitude: -149.7522    ), title: "Кошка", subtitle: "America"),
    PlacePoint(type: .shop, coordinate: CLLocationCoordinate2D(latitude:  61.19525062,   longitude: -149.8643361 ), title: "Империя Фудс", subtitle: "America"),
    PlacePoint(type: .shop, coordinate: CLLocationCoordinate2D(latitude:  61.13751355,   longitude: -149.8379726 ), title: "Корзинка", subtitle: "America"),
    PlacePoint(type: .shop, coordinate: CLLocationCoordinate2D(latitude:  61.13994658,   longitude: -149.9092788 ), title: "Колобок", subtitle: "America"),
    PlacePoint(type: .shop, coordinate: CLLocationCoordinate2D(latitude:  61.19533265,   longitude: -149.7364877 ), title: "Ханян", subtitle: "America"),
    PlacePoint(type: .shop, coordinate: CLLocationCoordinate2D(latitude:  61.2156    ,   longitude: -149.8211    ), title: "Пекарня", subtitle: "America"),
    PlacePoint(type: .cafe, coordinate: CLLocationCoordinate2D(latitude:  61.13806145,   longitude: -149.8445832 ), title: "Текколь", subtitle: "America"),
    PlacePoint(type: .cafe, coordinate: CLLocationCoordinate2D(latitude:  61.176693  ,     longitude: -149.9728678), title: "Валерия", subtitle: "America"),
    PlacePoint(type: .cafe, coordinate: CLLocationCoordinate2D(latitude:  61.14473454,   longitude: -149.8638034 ), title: "Куйлюк", subtitle: "America"),
]
