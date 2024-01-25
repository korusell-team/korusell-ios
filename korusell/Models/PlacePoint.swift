//
//  PlacePoint.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/06.
//

import Foundation
import MapKit
import FirebaseFirestoreSwift

class PlacePoint: NSObject, MKAnnotation, Identifiable {
    var pid: String
    var title: String?
    var subtitle: String?
    var city: Int?
    var coordinate: CLLocationCoordinate2D
    var categories: [Int]
    var address: String?
    var bio: String?
    var phone: String?
    var info: String?
    var images: [String]
    var smallImages: [String]
    var imagesPaths: [String]
    var smallImagesPaths: [String]
    
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
    var priority: Int?
    
    init(pid: String,
         title: String? = nil,
         subtitle: String? = nil,
         city: Int? = nil,
         latitude: Double,
         longitude: Double,
         categories: [Int],
         address: String? = nil,
         bio: String? = nil,
         phone: String? = nil,
         info: String? = nil,
         images: [String] = [],
         smallImages: [String] = [],
         imagesPaths: [String] = [],
         smallImagesPaths: [String] = [],
         instagram: String? = nil,
         
         threads: String? = nil,
         youtube: String? = nil,
         link: String? = nil,
         facebook: String? = nil,
         telegram: String? = nil,
         whatsApp: String? = nil,
         kakao: String? = nil,
         tiktok: String? = nil,
         linkedIn: String? = nil,
         twitter: String? = nil,
         blockedBy: [String] = [],
         reports: [String] = [],
         priority: Int?
    ) {
        self.pid = pid
        self.title = title
        self.subtitle = subtitle
        self.city = city
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.categories = categories
        self.address = address
        self.bio = bio
        self.phone = phone
        self.info = info
        self.images = images
        self.smallImages = smallImages
        self.imagesPaths = imagesPaths
        self.smallImagesPaths = smallImagesPaths
        self.instagram = instagram
        self.threads = threads
        self.youtube = youtube
        self.link = link
        self.facebook = facebook
        self.telegram = telegram
        self.whatsApp = whatsApp
        self.kakao = kakao
        self.tiktok = tiktok
        self.linkedIn = linkedIn
        self.twitter = twitter
        self.blockedBy = blockedBy
        self.reports = reports
        self.priority = priority
    }
}
