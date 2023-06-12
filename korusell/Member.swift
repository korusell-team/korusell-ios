//
//  Member.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import Foundation

struct Member: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let surname: String
//    let nickname: String
    var image: String? = nil
    var categories: [Category] = []
//    var tags: [String] = []
    var likes: [String] = []
    var marks: [String] = []
    var phone: String? = nil
    var instagram: String? = nil
    var link: String? = nil
    var details: String? = nil
}
