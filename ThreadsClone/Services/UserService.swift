//
//  UserService.swift
//  ThreadsClone
//
//  Created by ayman on 22/09/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class UserService {
    @Published var currentUser : User?
    
    static let shared = UserService()
    
    init() {
        Task{
            try await fetchCurrentUser()
        }
        
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else{return }
        let userData = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user  = try userData.data(as:User.self)
        self.currentUser = user
        print("DEBUG: user is \(user)")
    }
    
    static func fetchUsers() async throws ->[User]{
        guard let currentUid = Auth.auth().currentUser?.uid  else {return []}
        let UsersData =  try await Firestore.firestore().collection("users").getDocuments()
        let users = UsersData.documents.compactMap({try? $0.data(as: User.self)})
        return users.filter({$0.id != currentUid})
    }
    
    static func fetchUser (withUid uid : String )async throws -> User {
        let userData = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try userData.data(as: User.self)
    }
    func LogOutReset(){
        self.currentUser = nil 
    }
    @MainActor
    func updateUserProfileImge (withImageUrl imageUrl : String ) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid  else {return }
        try await Firestore.firestore().collection("users").document(currentUid).updateData([
            "profileImageUrl":imageUrl
        ])
        self.currentUser?.profileImageUrl = imageUrl
    }
}
