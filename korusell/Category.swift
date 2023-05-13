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
    var image: String
    var tags: [String] = []
}
