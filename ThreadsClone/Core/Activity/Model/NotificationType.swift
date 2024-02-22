//
//  NotificationType.swift
//  ThreadsClone
//
//  Created by ayman on 18/02/2024.
//

import Foundation
enum NotificationType:String, Codable {
    case follow
    case replay
    case like
    
    var notficatinDescrption:String {
        switch self {
        case.replay: return "replied to one of your Threads "
        case.follow : return"Followed you"
        case.like : return "Liked your Thread"
        }
    }
    var iconSystemName:String{
        switch self{
        case.follow:return "person.circle.fill"
        case.like :return "heart.fill"
        case.replay : return "arrow.uturn.left.circle.fill"
        }
    }
}
