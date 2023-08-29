//
//  Contact.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import Foundation

struct Contact: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let surname: String
    var bio: String
    var cities: [String] = []
    var image: [String] = []
    var categories: [String] = []
    var subcategories: [String] = []
    var phone: String? = nil
    var instagram: String? = nil
    var youtube: String? = nil
    var link: String? = nil
    var telegram: String? = nil
    var kakao: String? = nil
    var description: String? = nil
    /// places ids?
    var places: [String] = []
}
