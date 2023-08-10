//
//  Place.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/04.
//

import Foundation

struct Place: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var image: String? = nil
    var cities: [String] = []
    var categories: [String] = []
    var subcategories: [String] = []
    var phone: String? = nil
    var instagram: String? = nil
    var youtube: String? = nil
    var link: String? = nil
    var telegram: String? = nil
    var kakao: String? = nil
    var description: String? = nil
    var owner: String
    var latitude: Double? = nil
    var longitude: Double? = nil
}
