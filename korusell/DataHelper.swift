//
//  Data.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import Foundation
import MapKit

let fakeUser = Contact(name: "Сергей", surname: "Ли", bio: "\niOS", image: ["sergey-lee"], categories: ["IT"], subcategories: ["💻Программирование", "📱Приложения", "🍏iOS"])


let DummyCategories: [Category] = [
    Category(name: "Дизайн", image: "", subCategories: ["UI/UX", "Web", "Графический дизайн"]),
    Category(name: "IT", image: "", subCategories: ["Программирование", "Приложения", "iOS", "Android", "Сайты"]),
    Category(name: "Образование", image: "", subCategories: ["Смена-Визы", "Корейский язык", "Дизайн", "Программирование", "Школа", "Автошкола"]),
    Category(name: "Мероприятия", image: "", subCategories: ["Ведущий", "Тамада", "Вокалист", "Певец", "Цветы"]),
    Category(name: "Фото-Видео", image: "", subCategories: ["Видеограф", "Фотограф", "Праздник", "Мероприятия"]),
    Category(name: "Маркетинг", image: "", subCategories: ["Продажи", "Продвижение", "SMM"]),
    Category(name: "Переводы", image: "", subCategories: ["Переводчик", "Корейский", "Английский"]),
    Category(name: "Здоровье-Красота", image: "", subCategories: ["Стоматология", "Косметика", "Тату", "Парикмахер", "Визажист", "Маникюр", "Педикюр", "Ресницы", "Пластическая хирургия", "Гинекология"]),
    Category(name: "Транспорт", image: "", subCategories: ["Перевозки", "Купля-Продажа", "Экспорт", "СТО", "Тюнинг", "Электрик"]),
    Category(name: "Ремонт", image: "", subCategories: ["Электроника", "Квартиры", "Сантехник", "Электрик"]),
]


//let listOfCategories: [Category] = [
//    Category(name: "Дизайн", image: "✏️", subcategories: ["📱UI/UX", "🌐Web", "✏️Графический дизайн"]),
//    Category(name: "IT", image: "🖥️", subcategories: ["💻Программирование", "📱Приложения", "🍏iOS", "🤖Android", "🌐Сайты"]),
//    Category(name: "Образование", image: "🎓", subcategories: ["🛂Смена-Визы", "🇰🇷Корейский язык", "✏️Дизайн", "💻Программирование", "🧑🏻‍🏫Школа", "🚙Автошкола"]),
//    Category(name: "Мероприятия", image: "🎉", subcategories: ["🦸🏻‍♂️Ведущий", "🤵🏻‍♂️Тамада", "🎤Вокалист", "🧑‍🎤Певец", "🌷Цветы"]),
//    Category(name: "Фото-Видео", image: "📷", subcategories: ["🎥Видеограф", "📷Фотограф", "🎉Праздник", "🎁Мероприятия"]),
//    Category(name: "Маркетинг", image: "📈", subcategories: ["💸Продажи", "📢Продвижение", "💭SMM"]),
//    Category(name: "Переводы", image: "💬", subcategories: ["💬Переводчик", "🇰🇷Корейский", "🇬🇧Английский"]),
//    Category(name: "Здоровье-Красота", image: "🏥", subcategories: ["🦷Стоматология", "💄Косметика", "㆞Тату", "💇🏻Парикмахер", "👧🏻Визажист", "💅🏼Маникюр", "🦶Педикюр", "👁️Ресницы", "👨🏻‍⚕️Пластическая хирургия", "👩‍⚕️Гинекология"]),
//    Category(name: "Транспорт", image: "🛞", subcategories: ["🚚Перевозки", "🚗Купля-Продажа", "🚢Экспорт", "⚙️СТО", "🏎️Тюнинг", "⚡️Электрик"]),
//    Category(name: "Ремонт", image: "🛠️", subcategories: ["🎧Электроника", "🏠Квартиры", "🛁Сантехник", "⚡️Электрик"]),
//]

let dummyContacts: [Contact] = [
    Contact(name: "Евгений", surname: "Ким", bio: "Лучший Ведущий мероприятий\nв Южной Корее!", image: ["evgeniy-hvan"], categories: ["Мероприятия"], subcategories: ["Ведущий", "Тамада"], phone: "01012341234", instagram: "https://instagram.com/vlog.vedushego?igshid=OGQ5ZDc2ODk2ZA=="),
    Contact(name: "Сергей", surname: "Ли", bio: "\niOS", image: ["sergey-lee"], categories: ["IT"], subcategories: ["Программирование", "Приложения", "iOS"]),
    Contact(name: "Антон", surname: "Емельянов", bio: "fullstack\ndeveloper", categories: ["IT"], subcategories: ["Программирование", "Сайты"]),
    Contact(name: "Андрей", surname: "Ким", bio: "я просто рандомный чел...🤪", categories: ["Переводы"], subcategories: ["Английский"]),
    Contact(name: "Владимир", surname: "Мун", bio: "Habsida. Школа программирования и дизайна. С оплатой после трудоустройства!", cities: ["Сеул"], image: ["vladimir-mun", "vladimir-mun2"], categories: ["Образование"], subcategories: ["Дизайн", "Программирование"], phone: "010-1234-1234", instagram: "munvova", link: "https://habsida.com/ru", telegram: "vladimun"
//            places: [
//    Place(name: "Habsida School1", image: "habsida", owner: "010-1234-1234"),
//    Place(name: "Imperia Foods1", image: "imperia-foods", owner: "12341234"),
//    Place(name: "Habsida School2", image: "habsida", owner: "010-1234-1234"),
//    Place(name: "Imperia Foods2", image: "imperia-foods", owner: "12341234"),
//    Place(name: "Habsida School3", image: "habsida", owner: "010-1234-1234"),
//    Place(name: "Imperia Foods3", image: "imperia-foods", owner: "12341234"),
//    Place(name: "Habsida School4", image: "habsida", owner: "010-1234-1234"),
//    Place(name: "Imperia Foods5", image: "imperia-foods", owner: "12341234"),
//    ]
           ),

    Contact(name: "Владимир", surname: "Тен", bio: "Основатель школы корейского языка 'Korean Simple' и далее длинное описание услуг которые может предоставить данный человек", image: ["vladimir-ten", "vladimir-ten2"], categories: ["Образование"], subcategories: ["Корейский язык"], phone: "01012341234", instagram: "vladimirten", youtube: "korean_simple", telegram: "vladimir_ten", kakao: "http://qr.kakao.com/talk/hKynt3kFP0Jd_1eJ1L7vui6kY4s-"),
    
    Contact(name: "Игорь", surname: "Кан", bio: "Лучший PHP бекенд программист в Южной Корее", image: ["igor-kan"], categories: ["IT"], subcategories: ["Программирование", "Сайты"], phone: "01011111111", instagram: "rogi.nak", telegram: "IgorKan"),
    
    Contact(name: "David", surname: "Beckham", bio: "I'm here to check if english content displays properly", image: ["david-beckham"], categories: ["Маркетинг"], subcategories: ["Продажи"], instagram: "https://www.instagram.com/davidbeckham"),
]

let listOfPlaces: [Place] = [
    Place(name: "Кафе Виктория", subcategories: ["мероприятия", "праздники", "свадьбы", "асянди", "хангаби"], owner: "sad"),
    Place(name: "Habsida", subcategories: ["Образование", "IT", "программирование", "обучение"], owner: "sad"),
    Place(name: "СТО", subcategories: ["транспорт", "ремонт"], owner: "sad"),
]

let dummyCities: [City] = [
    City(ru: "Сеул", en: "Seoul", ko: "서울"),
    City(ru: "Ансан", en: "Ansan", ko: "안산"),
    City(ru: "Инчхон", en: "Incheon", ko: "인천"),
    City(ru: "Сувон", en: "Suwon", ko: "수원"),
    City(ru: "Хвасонг", en: "Hwaseong", ko: "화성"),
    City(ru: "Пусан", en: "Seoul", ko: "서울"),
    City(ru: "Сеул", en: "Busan", ko: "부산")
]


var data: [PlacePoint] = [
    
    PlacePoint(type: .cafe, address: "서울%20영등포구%20여의도동%2084-1", coordinate: CLLocationCoordinate2D(latitude:  61.19533942,   longitude: -149.9054948 ), title: "У Тани", bio: "America"),
    PlacePoint(type: .cafe, coordinate: CLLocationCoordinate2D(latitude:  61.2297    ,   longitude: -149.7522    ), title: "Кошка", bio: "America"),
    PlacePoint(type: .shop, coordinate: CLLocationCoordinate2D(latitude:  61.19525062,   longitude: -149.8643361 ), title: "Империя Фудс", bio: "America"),
    PlacePoint(type: .shop, coordinate: CLLocationCoordinate2D(latitude:  61.13751355,   longitude: -149.8379726 ), title: "Корзинка", bio: "America"),
    PlacePoint(type: .shop, coordinate: CLLocationCoordinate2D(latitude:  61.13994658,   longitude: -149.9092788 ), title: "Колобок", bio: "America"),
    PlacePoint(type: .shop, coordinate: CLLocationCoordinate2D(latitude:  61.19533265,   longitude: -149.7364877 ), title: "Ханян", bio: "America"),
    PlacePoint(type: .shop, coordinate: CLLocationCoordinate2D(latitude:  61.2156    ,   longitude: -149.8211    ), title: "Пекарня", bio: "America"),
    PlacePoint(type: .cafe, coordinate: CLLocationCoordinate2D(latitude:  61.13806145,   longitude: -149.8445832 ), title: "Текколь", bio: "America"),
    PlacePoint(type: .cafe, coordinate: CLLocationCoordinate2D(latitude:  61.176693  ,     longitude: -149.9728678), title: "Валерия", bio: "America"),
    PlacePoint(type: .cafe, coordinate: CLLocationCoordinate2D(latitude:  61.14473454,   longitude: -149.8638034 ), title: "Куйлюк", bio: "America"),
]
