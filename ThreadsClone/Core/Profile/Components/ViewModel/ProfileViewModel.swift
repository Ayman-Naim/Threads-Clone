//
//  ProfileViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 17/02/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
class ProfilViewModel :ObservableObject{
    @Published var isFollowed = false
    
    
    func follow(user : User,Isfollow:Bool ) async  throws{
        guard let currentUser = UserService.shared.currentUser else {return}
        // the followed person followers list list
        let snapshotFollwoed = try await  Firestore.firestore().collection("users").document(user.id).getDocument()
        let followedUser = try snapshotFollwoed.data(as: User.self)
        var followedUserFollowersList = followedUser.follwers
       
        
        // user following list
        let snapshotFollowing = try await  Firestore.firestore().collection("users").document(currentUser.id).getDocument()
        let followinguser = try snapshotFollowing.data(as: User.self)
        var followingUserFollowersList = followinguser.following
      
        
        if Isfollow{
            // add current user to the folloer and folloeing list
            followedUserFollowersList?.append(currentUser.id)
            followingUserFollowersList?.append(user.id)
            print("/***********************/")
            print(currentUser.id)
            print(user.id)
            print(followedUser)
            print(followinguser)
            print(followingUserFollowersList)
            print(followedUserFollowersList)
            print("/***********************/")
            UserService.shared.currentUser?.following?.append(user.id)

        }else{
          //   remove both from each other
            followedUserFollowersList?.removeAll{$0 == currentUser.id}
            followingUserFollowersList?.removeAll{$0 == user.id}
            UserService.shared.currentUser?.following?.removeAll{$0 == user.id}
            
        }
        
        try await  Firestore.firestore().collection("users").document(user.id).setData(["follwers":followedUserFollowersList], merge: true)
        try await  Firestore.firestore().collection("users").document(currentUser.id).setData(["following":followingUserFollowersList], merge: true)
       
      
        
        
        
    }
    
    func isFollowed(user:User)->Bool{
        guard let currentUser =  UserService.shared.currentUser else{return false   }
        
        if currentUser.following?.contains(user.id) == true {
            self.isFollowed = true
            return true
        }
        self.isFollowed = false
        return false
    }
}
