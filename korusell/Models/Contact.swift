//
//  Contact.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import Foundation

import FirebaseFirestoreSwift

struct Contact: Identifiable, Hashable, Codable {
    var id: String?
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
    
    static func fromCodingContact(codingContact: CodingContact) -> Contact {
        return Contact(
            id: codingContact.id,
            uid: codingContact.uid,
            name: codingContact.name,
            surname: codingContact.surname,
            bio: codingContact.bio,
            info: codingContact.info,
            cities: codingContact.cities ?? [],
            image: codingContact.image ?? [],
            imagePath: codingContact.imagePath ?? [],
            smallImage: codingContact.smallImage,
            smallImagePath: codingContact.smallImagePath,
            categories: codingContact.categories ?? [],
            phone: codingContact.phone,
            updated: codingContact.updated,
            created: codingContact.created,
            isPublic: codingContact.isPublic,
            phoneIsAvailable: codingContact.phoneIsAvailable,
            
            instagram: codingContact.instagram,
            threads: codingContact.threads,
            youtube: codingContact.youtube,
            link: codingContact.link,
            facebook: codingContact.facebook,
            telegram: codingContact.telegram,
            whatsApp: codingContact.whatsApp,
            kakao: codingContact.kakao,
            tiktok: codingContact.tiktok,
            linkedIn: codingContact.linkedIn,
            twitter: codingContact.twitter,
            
            blockedBy: codingContact.blockedBy ?? [],
            reports: codingContact.reports ?? [],
            likes: codingContact.likes ?? [],
            isOnline: codingContact.isOnline,
            priority: codingContact.priority
            )
    }
    /// places ids?
//    var places: [Place] = []
}

struct CodingContact: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var uid: String
    var name: String?
    var surname: String?
    var bio: String?
    var info: String?
    var cities: [Int]? = []
    var image: [String]? = []
    var imagePath: [String]? = []
    var smallImage: String?
    var smallImagePath: String?
    var categories: [Int]? = []
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
    
    var blockedBy: [String]? = []
    var reports: [String]? = []
    var likes: [String]? = []
    var isOnline: Bool?
    var priority: Int?
    
    /// places ids?
//    var places: [Place] = []
}
