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
    var likesAcounts : [String]?
    var repliesCount :Int
    var repliesAccounts:[String]?
    var id : String {
        return  threadId ?? NSUUID().uuidString
    }
    
    mutating func like(LikesUser:String,liked:Bool){
        if liked{
            self.likes += 1
            self.likesAcounts?.append(LikesUser)
        }
        else{
            self.likes -= 1
            self.likesAcounts?.removeAll{$0 == LikesUser}
        }
        
    }
}

