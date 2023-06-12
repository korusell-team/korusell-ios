//
//  Category.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let subcategories: [Subcategory]
}

struct Subcategory: Equatable, Hashable {
    let name: String
}

struct CategoryData {
    var categories: [Category]
}

class CategoryDataSource {
    var data: CategoryData
    
    init() {
        // Initialize your data
        data = CategoryData(categories: [
            Category(name: "Дизайн", subcategories: [
                Subcategory(name: "UI/UX"),
                Subcategory(name: "Web"),
                Subcategory(name: "Графика"),
            ]),
            Category(name: "IT", subcategories: [
                Subcategory(name: "Subcategory 2.1"),
                Subcategory(name: "Subcategory 2.2")
            ])
        ])
    }
}
add everything in a new structure...
let listOfCategories: [Category] = [
    Category(name: "Дизайн", image: "design", tags: ["Дизайн", "UI/UX", "Web", "Графика"]),
    Category(name: "IT", image: "IT", tags: ["IT", "программирование", "приложения", "сайты", "web"]),
    Category(name: "Фото-Видео", image: "photo", tags: ["видео", "фото", "праздник", "мероприятия"]),
    Category(name: "Маркетинг", image: "marketing", tags: ["маркетинг", "продажи", "продвижение", "СММ", "SMM", "marketing"]),
    Category(name: "Переводы", image: "translate", tags: ["translate", "переводы", "переводчик", "корейский", "английский"]),
    Category(name: "Здоровье-Красота", image: "health", tags: ["здоровье", "красота", "стоматология", "косметика", "тату", "парикмахер", "визажист", "маникюр", "педикюр", "зубной", "ресницы", "пластика", "гинекология"]),
    Category(name: "Транспорт", image: "transport", tags: ["transport", "транспорт", "перевозки", "груз", "автомобиль", "купля", "продажа", "экспорт", "СТО", "ремонт", "тюнинг"]),
    Category(name: "Образование", image: "education", tags: ["образование", "смена", "виза", "корейский", "язык", "дизайн", "программирование", "курсы"]),
    Category(name: "Ремонт", image: "repair", tags: ["ремонт", "электроника", "техника", "дом", "квартиры", "помещение", "сантехника", "электрика"]),
    Category(name: "Мероприятия", image: "event", tags: ["праздник", "мероприятия", "ведущий", "тамада", "вокалист", "певец"])
]
