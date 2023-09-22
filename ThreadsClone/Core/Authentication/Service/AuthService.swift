//
//  AuthService.swift
//  ThreadsClone
//
//  Created by ayman on 12/09/2023.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
class AuthService {
    @Published var userSessoion : FirebaseAuth.User?
    
    init(){
        self.userSessoion = Auth.auth().currentUser
    }
    
    static let shared = AuthService()
    
    @MainActor
    func login(withEmail email: String , password :String) async throws {
        do{
            let result = try  await Auth.auth().signIn(withEmail: email, password: password)
            self.userSessoion = result.user
            try await UserService.shared.fetchCurrentUser()
            print("DEBUG: login sucseed\(result.user.uid)")
        }catch{
            print("DEBUG: cant login  \(error.localizedDescription)")
            throw SignError.emailIsSignedBefore
            
        }
    }
    
    @MainActor
    func CreateUser(withEmail email: String , password :String ,fullName:String ,userName:String ) async throws {
        do{
            let result = try  await Auth.auth().createUser(withEmail: email, password: password)
            //self.userSessoion = result.user
            try await uploadUserData(withEmail: email, password: password, fullName: fullName, userName: userName, id: result.user.uid)
            print("DEBUG Created user \(result.user.uid)")
        }catch{
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            throw SignError.emailIsSignedBefore
            
        }
    }
    
    func SignOut(){
        try? Auth.auth().signOut()  // this sign out on backend
        self.userSessoion = nil // this remove session locally and update the routing
        UserService.shared.LogOutReset() // to set the user to nil as you sign out 
    }
    @MainActor
    private func uploadUserData(
        withEmail email: String,
        password :String,
        fullName:String,
        userName:String,
        id:String
    ) async throws {
        let user = User(id: id, fullName: fullName, email: email, userName: userName)
        guard let userData = try? Firestore.Encoder().encode(user) else{ return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
          
    }
    
    
}
