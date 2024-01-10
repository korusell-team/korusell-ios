//
//  City.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/24.
//

import Foundation

struct City: Codable, Equatable, Hashable {
    let id: Int
    let ru: String
    let en: String
    let ko: String
}
