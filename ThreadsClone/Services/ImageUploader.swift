//
//  ImageUploader.swift
//  ThreadsClone
//
//  Created by ayman on 05/12/2023.
//

import Foundation
import FirebaseStorage

struct ImageUploader {
    static func uploadImage (_ image : UIImage) async throws -> String? {
        guard let imageData =  image.jpegData(compressionQuality: 0.25) else {return nil }
        let fileName = NSUUID().uuidString
        let storgeRef = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        do {
            let _ = try await storgeRef.putDataAsync(imageData)
            let url = try await storgeRef.downloadURL()
            return url.absoluteString
        }catch{
            print("Debug : fialed to upload imafe with error \(error)")
            return nil 
        }
    }
    
}
