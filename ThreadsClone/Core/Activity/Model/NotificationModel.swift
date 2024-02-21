//
//  NotificationModel.swift
//  ThreadsClone
//
//  Created by ayman on 18/02/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
struct NotficationModel:Codable ,Identifiable {
    let notifcatonType : NotificationType
    let fromUserID : String
    var noticationStatus:NotifcationStatus
    let refrence:String?
    var id = UUID().uuidString
    let timeStamp:Timestamp
    var fromUser : User?
    var threadRef : Thread?
    
}
struct Notfictation:Codable{
    var notifications : [NotficationModel]
}

enum NotifcationStatus:String,Codable{
    case read
    case unRead
    
    
}
