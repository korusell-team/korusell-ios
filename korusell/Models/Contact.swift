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
    var info: String?
    var cities: [Int] = []
    var image: [String] = []
    var imagePath: [String] = []
    var smallImage: String?
    var smallImagePath: String?
    var categories: [Int] = []
    var phone: String
    var updated: Date?
    var created: Date?
    var isPublic: Bool
    var phoneIsAvailable: Bool?
    
    var instagram: String?
    var threads: String?
    var youtube: String?
    var link: String?
    var facebook: String?
    var telegram: String?
    var whatsApp: String?
    var kakao: String?
    var tiktok: String?
    var linkedIn: String?
    var twitter: String?
    
    var blockedBy: [String] = []
    var reports: [String] = []
    var likes: [String] = []
    var isOnline: Bool?
    var priority: Int?
    
    /// places ids?
//    var places: [Place] = []
}
