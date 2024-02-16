//
//  ThreadReplay.swift
//  ThreadsClone
//
//  Created by ayman on 15/02/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
struct ThreadReplay :Codable,Identifiable{
    var id = UUID().uuidString
    let replay :String
    let replayUserId:String
    let timeStamp:Timestamp
}
