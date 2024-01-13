//
//  Thread.swift
//  ThreadsClone
//
//  Created by ayman on 13/01/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Thread:Identifiable,Codable{
    @DocumentID var threadId: String?
    
    let ownerUid:String
    let timeStamp:Timestamp
    let caption : String
    var likes : Int
    var user : User?
    
    
    
    var id : String {
        return  threadId ?? NSUUID().uuidString
    }
    
}

