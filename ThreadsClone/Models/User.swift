//
//  User.swift
//  ThreadsClone
//
//  Created by ayman on 22/09/2023.
//

import Foundation


struct User : Identifiable , Codable ,Hashable{
    let id : String
    let fullName : String
    let email: String
    let userName: String
    let profileImageUrl: String?
    var bio: String?
    
    init(id:String,fullName:String,email:String,userName:String) {
        self.id = id
        self.fullName =  fullName
        self.email = email
        self.userName = userName
        self.profileImageUrl = nil
        self.bio = nil
    }
}
