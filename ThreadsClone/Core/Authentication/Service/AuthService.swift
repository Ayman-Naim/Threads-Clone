//
//  AuthService.swift
//  ThreadsClone
//
//  Created by ayman on 12/09/2023.
//

import FirebaseAuth
class AuthService {
    
    static let shared = AuthService()
    
    @MainActor
    func login(withEmail email: String , password :String) async throws {
        
    }
    
    @MainActor
    func CreateUser(withEmail email: String , password :String ,fullName:String ,userName:String ) async throws {
        do{
            let result = try  await Auth.auth().createUser(withEmail: email, password: password)
            print("DEBUG Created user \(result.user.uid)")
        }catch{
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            throw SignError.emailIsSignedBefore
            
        }
    }
}
