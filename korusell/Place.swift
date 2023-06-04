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
    var tags: [String] = []
    var likes: [String] = []
    var marks: [String] = []
    var phone: String? = nil
    var instagram: String? = nil
    var link: String? = nil
    var details: String? = nil
    var latitude: Double? = nil
    var longitude: Double? = nil
}
