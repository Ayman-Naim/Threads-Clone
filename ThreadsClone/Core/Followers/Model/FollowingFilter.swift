//
//  FollowingFilter.swift
//  ThreadsClone
//
//  Created by ayman on 23/01/2024.
//

import Foundation
enum FollowingFilter : Int ,CaseIterable,Identifiable{
    case followers
    case following
    var title : String {
        switch self{
        case.following : return "Following"
        case.followers : return "Followers"
        }
    }
    var id : Int{return self.rawValue}
}
