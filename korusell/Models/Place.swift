//
//  Place.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/04.
//

import Foundation
import FirebaseFirestore
import MapKit

struct Place: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var pid: String
    var title: String? = nil
    var subtitle: String? = nil
    var city: Int? = nil
    var latitude: Double
    var longitude: Double
    var categories: [Int]
    var address: String? = nil
    var bio: String? = nil
    var phone: String? = nil
    var info: String? = nil
    var images: [String] = []
    var smallImages: [String] = []
    var imagesPaths: [String] = []
    var smallImagesPaths: [String] = []
    var instagram: String? = nil
    
    var threads: String? = nil
    var youtube: String? = nil
    var link: String? = nil
    var facebook: String? = nil
    var telegram: String? = nil
    var whatsApp: String? = nil
    var kakao: String? = nil
    var tiktok: String? = nil
    var linkedIn: String? = nil
    var twitter: String? = nil
    
    var blockedBy: [String] = []
    var reports: [String] = []
    var priority: Int?
    
    func toPlacePoint() -> PlacePoint {
        return PlacePoint(
            pid: self.pid,
            title: self.title,
            subtitle: self.subtitle,
            city: self.city,
            latitude: self.latitude, 
            longitude: self.longitude,
            categories: self.categories,
            address: self.address,
            bio: self.bio,
            phone: self.phone,
            info: self.info,
            images: self.images,
            smallImages: self.smallImages,
            imagesPaths: self.imagesPaths,
            smallImagesPaths: self.smallImagesPaths,
            instagram: self.instagram,
            threads: self.threads,
            youtube: self.youtube,
            link: self.link,
            facebook: self.facebook,
            telegram: self.telegram,
            whatsApp: self.whatsApp,
            kakao: self.kakao,
            tiktok: self.tiktok,
            linkedIn: self.linkedIn,
            twitter: self.twitter,
            blockedBy: self.blockedBy,
            reports: self.reports,
            priority: self.priority
        )
    }
}
