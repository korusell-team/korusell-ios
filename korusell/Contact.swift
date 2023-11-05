//
//  Contact.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import Foundation

import FirebaseFirestoreSwift

struct Contact: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var uid: String
    var name: String?
    var surname: String?
    var bio: String?
    var cities: [String] = []
    var image: [String] = []
    var categories: [Int] = []
    var phone: String
    var instagram: String?
    var youtube: String?
    var link: String?
    var telegram: String?
    var kakao: String?
    var tiktok: String?
    var updated: Date?
    var created: Date?
    var isPublic: Bool?
    var isOnline: Bool?
    
    /// places ids?
//    var places: [Place] = []
}
