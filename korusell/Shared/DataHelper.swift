//
//  Data.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import Foundation
import MapKit

let dummyUser = Contact(
    uid: "jFw6tzSYiJNxkCL3kDXT8zUXMyw2",
    name: "Сергей",
    surname: "Ли",
    bio: "\niOS",
    cities: [1,2,3,4,5],
    image: ["https://firebasestorage.googleapis.com:443/v0/b/inkorea-bfee4.appspot.com/o/avatars%2FjFw6tzSYiJNxkCL3kDXT8zUXMyw2%2F106C775A-04ED-4B07-91E6-FFB233904284.jpeg?alt=media&token=a0516a74-3abf-405f-82b8-afc0bcf4b465"],
    categories: [901,902,101],
    phone: "+821083872508",
    isPublic: true)


//let DummyCategories: [Category] = [
//    Category(name: "Дизайн", image: "", subCategories: ["UI/UX", "Web", "Графический дизайн"]),
//    Category(name: "IT", image: "", subCategories: ["Программирование", "Приложения", "iOS", "Android", "Сайты"]),
//    Category(name: "Образование", image: "", subCategories: ["Смена-Визы", "Корейский язык", "Дизайн", "Программирование", "Школа", "Автошкола"]),
//    Category(name: "Мероприятия", image: "", subCategories: ["Ведущий", "Тамада", "Вокалист", "Певец", "Цветы"]),
//    Category(name: "Фото-Видео", image: "", subCategories: ["Видеограф", "Фотограф", "Праздник", "Мероприятия"]),
//    Category(name: "Маркетинг", image: "", subCategories: ["Продажи", "Продвижение", "SMM"]),
//    Category(name: "Переводы", image: "", subCategories: ["Переводчик", "Корейский", "Английский"]),
//    Category(name: "Здоровье-Красота", image: "", subCategories: ["Стоматология", "Косметика", "Тату", "Парикмахер", "Визажист", "Маникюр", "Педикюр", "Ресницы", "Пластическая хирургия", "Гинекология"]),
//    Category(name: "Транспорт", image: "", subCategories: ["Перевозки", "Купля-Продажа", "Экспорт", "СТО", "Тюнинг", "Электрик"]),
//    Category(name: "Ремонт", image: "", subCategories: ["Электроника", "Квартиры", "Сантехник", "Электрик"]),
//]


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

//let dummyContacts: [Contact] = [
//    Contact(uid: "", name: "Евгений", surname: "Ким", bio: "Лучший Ведущий мероприятий\nв Южной Корее!", image: ["evgeniy-hvan"], categories: ["Мероприятия"], subcategories: ["Ведущий", "Тамада"], phone: "01012341234", instagram: "https://instagram.com/vlog.vedushego?igshid=OGQ5ZDc2ODk2ZA=="),
//    Contact(uid: "", name: "Сергей", surname: "Ли", bio: "\niOS", image: ["sergey-lee"], categories: ["IT"], subcategories: ["Программирование", "Приложения", "iOS"], phone: "112331333"),
//    
//    Contact(uid: "", name: "Антон", surname: "Емельянов", bio: "fullstack\ndeveloper", categories: ["IT"], subcategories: ["Программирование", "Сайты"], phone: "112331333"),
//    Contact(uid: "", name: "Андрей", surname: "Ким", bio: "я просто рандомный чел...🤪", categories: ["Переводы"], subcategories: ["Английский"], phone: "112331333"),
//    Contact(uid: "", name: "Владимир", surname: "Мун", bio: "Habsida. Школа программирования и дизайна. С оплатой после трудоустройства!", cities: ["Сеул"], image: ["vladimir-mun", "vladimir-mun2"], categories: ["Образование"], subcategories: ["Дизайн", "Программирование"], phone: "010-1234-1234", instagram: "munvova", link: "https://habsida.com/ru", telegram: "vladimun"),
//    Contact(uid: "", name: "Владимир", surname: "Тен", bio: "Основатель школы корейского языка 'Korean Simple' и далее длинное описание услуг которые может предоставить данный человек", image: ["vladimir-ten", "vladimir-ten2"], categories: ["Образование"], subcategories: ["Корейский язык"], phone: "01012341234", instagram: "vladimirten", youtube: "korean_simple", telegram: "vladimir_ten", kakao: "http://qr.kakao.com/talk/hKynt3kFP0Jd_1eJ1L7vui6kY4s-"),
//    Contact(uid: "", name: "Игорь", surname: "Кан", bio: "Лучший PHP бекенд программист в Южной Корее", image: ["igor-kan"], categories: ["IT"], subcategories: ["Программирование", "Сайты"], phone: "01011111111", instagram: "rogi.nak", telegram: "IgorKan"),
//    Contact(uid: "", name: "David", surname: "Beckham", bio: "I'm here to check if english content displays properly", image: ["david-beckham"], categories: ["Маркетинг"], subcategories: ["Продажи"], phone: "112331333", instagram: "https://www.instagram.com/davidbeckham"),
//]

let listOfPlaces: [Place] = [
    Place(name: "Кафе Виктория", image: "https://www.shuttledelivery.co.kr/uploads/_1c5541729a3513b9db5f712d8cdf26691556766796.jpg", subcategories: ["мероприятия", "праздники", "свадьбы", "асянди", "хангаби"], owner: "sad"),
    Place(name: "Habsida", image: "https://seeklogo.com/images/D/dunkin-donuts-logo-1E269BA8F1-seeklogo.com.png", subcategories: ["Образование", "IT", "программирование", "обучение"], owner: "sad"),
    Place(name: "СТО", image: "https://cdn.cookielaw.org/logos/94ba57b5-e5fc-4459-a91d-28bc381b6185/cbbac623-b9e1-4fa5-b22c-c59abdf87131/6956a7a6-b2b7-4930-8b81-174cb0def489/MicrosoftTeams-imagec5a4e92dea00544f64bbc54c6eab7f24841d0d022e5e883abe8838f725a633ce.png", subcategories: ["транспорт", "ремонт"], owner: "sad"),
]

let dummyCities: [City] = [
    City(id: 1, ru: "Сеул", en: "Seoul", ko: "서울"),
    City(id: 2, ru: "Инчхон", en: "Incheon", ko: "인천"),
    City(id: 3, ru: "Ансан", en: "Ansan", ko: "안산"),
    City(id: 4, ru: "Сувон", en: "Suwon", ko: "수원"),
    City(id: 6, ru: "Хвасонг", en: "Hwaseong", ko: "화성"),
    City(id: 5, ru: "Пусан", en: "Busan", ko: "부산"),
]


var dummyPlaces: [PlacePoint] = [
    PlacePoint(pid: "1", title: "LEE FLOWERS", city: 2, latitude:  37.30501026564322, longitude: 126.84550345674847, categories: [101], address: "경기 안산시 상록구 사동", bio: "“LEE FLOWER”| арт-студия •услуги флориста •мастер-класс по живописи •арт-терапия •душевные разговоры", phone: "01012340011", info: "“LEE FLOWER”| арт-студия •услуги флориста •мастер-класс по живописи •арт-терапия •душевные разговоры", images: ["https://firebasestorage.googleapis.com/v0/b/ethnogram-1cd0f.appspot.com/o/dummy%2FSimplyChic.jpg?alt=media&token=f551a867-2273-4ca3-bb39-a647ffd00c29"], smallImages: ["https://firebasestorage.googleapis.com/v0/b/ethnogram-1cd0f.appspot.com/o/dummy%2FSimplyChic.jpg?alt=media&token=f551a867-2273-4ca3-bb39-a647ffd00c29"], instagram: "l.eeflower"),
    PlacePoint(pid: "2", title: "Home Cafe", city: 2, latitude:  37.30227732026979, longitude: 126.84739799098557, categories: [101], address: "경기 안산시 상록구 사동", bio: "", phone: "+821021160770", info: "Кафе домашней кухни♥️", instagram: "home_cafe_ansan"),
]
