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
    
    func LogOutReset(){
        self.currentUser = nil 
    }
}
