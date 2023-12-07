//
//  StorageManager.swift
//  korusell
//
//  Created by Sergey Li on 11/20/23.
//

import SwiftUI
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
//    private let storage = Storage.storage().reference()
    
//    func saveImage(data: Data) async throws -> (path: String, name: String) {
//        let meta = StorageMetadata()
//        meta.contentType = "image/jpeg"
//        
//        let path = "\(UUID().uuidString).jpg"
//        let returnedMetaData = try await storage.child(path).putDataAsync(data, metadata: meta)
//        
//        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
//            throw URLError(.badServerResponse)
//        }
//        
//        return (returnedPath, returnedName)
//    }
    private func storage(dir: String, uid: String) -> StorageReference {
        Storage.storage().reference().child(dir).child(uid)
    }
    
    func getUrlForImage(dir: String, uid: String, path: String) async throws -> URL {
        try await storage(dir: dir, uid: uid).child(path).downloadURL()
    }
    
    func getData(dir: String, uid: String, path: String) async throws -> Data {
        try await storage(dir: dir, uid: uid).child(path).data(maxSize: 3 * 1024 * 1024)
    }
    
    func saveProfileImage(image: UIImage, directory: String, uid: String) async throws -> (path: String, name: String, pathSmall: String, nameSmall: String)  {
       
        let path = storage(dir: directory, uid: uid).child("\(UUID().uuidString).jpeg")
        let smallPath = storage(dir: directory, uid: uid).child("\(UUID().uuidString)-small.jpeg")
        
        // Resize the image to 200px in height with a custom extension
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))

        // Convert the image into JPEG and compress the quality to reduce its size (from 0 to 1)
        let data = resizedImage!.jpegData(compressionQuality: 0.5)
        let smallData = resizedImage!.jpegData(compressionQuality: 0.1)
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
            if let data = data, let smallData = smallData {
                let imageMeta = try await path.putDataAsync(data, metadata: meta)
                guard let imagePath = imageMeta.path, let imageName = imageMeta.name else {
                    throw URLError(.badServerResponse)
                }
                let smallImageMeta = try await smallPath.putDataAsync(smallData, metadata: meta)
                guard let smallImagePath = smallImageMeta.path, let smallImageName = smallImageMeta.name else {
                    throw URLError(.badServerResponse)
                }
                return (imagePath, imageName, smallImagePath, smallImageName)
            } else {
                throw URLError(.badServerResponse)
            }
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
