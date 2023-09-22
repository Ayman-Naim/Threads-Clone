//
//  RegisterationViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 11/09/2023.
//
import SwiftUI
import Foundation
class RegisterationViewModel:ObservableObject{
    @Published var error :Error?
    @Published  var email = ""
    @Published  var password = ""
    @Published  var fullName = ""
    @Published  var userName = ""
    @Published public  var userSignupSucsess = false
    @Published var formIsValid = false
    
    @MainActor
    func CreateUser () async throws{
        do{
            try  self.validate()
            try await AuthService.shared.CreateUser(
                
                withEmail: email,
                password: password,
                fullName: fullName,
                userName: userName
            )
            userSignupSucsess.toggle()
           
        }catch {
            self.error = error
            
        }
        
    }
    
    
    
}





extension RegisterationViewModel {
   
    //user name valdiation
    func isUserNameValid()->Bool  {
        let userNamePredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]{2,64}")
        return userNamePredicate.evaluate(with: userName)
    }
    //email valdiation
    func isEmailValid()->Bool{
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
            return emailPredicate.evaluate(with: email)
    }
    //password valdiarion
    func isPasswordValid()->Bool{
            return password.count >= 8
    }
   //full name validation
    func  isFullNameValid()->Bool {
            return fullName.count>=3
    }
    //function of all validation 
    func validate()  throws  {
       /* guard isFullNameValid() ,isUserNameValid(),isPasswordValid(),isEmailValid() else{
            throw SignError.emptyFileds
        }*/
        guard  isEmailValid() else{
            print("Debug: invalid email  \(isEmailValid() )")
            throw SignError.invalidEmail
        }
        guard  isPasswordValid() else{
            print("Debug: invalid pass \(isPasswordValid() )")
            throw SignError.invalidPassword
        }
        guard isFullNameValid() else{
            print("Debug: inavalid full name \(isFullNameValid())")
            throw SignError.invalidName
        }
        guard  isUserNameValid()  else{
            print("Debug: invalid user name \(isUserNameValid() )")
            throw SignError.invalidUserName
           
        }
       
        
        
        
    }
}
enum SignError:Error,LocalizedError{
    case invalidName
    case invalidPassword
    case invalidEmail
    case invalidUserName
    case emailIsSignedBefore
    case emptyFileds
    case signInError
    var errorDescription: String?{
        switch self{
        case .invalidEmail:
            return "This Email is invalid please Enter valid one "
        case .invalidPassword:
            return "This password is invalid enter password at least 8 digits "
        case .invalidName:
            return "This Name is invlaid  must be more than 3 char "
        case .invalidUserName:
            return "This user name is invalid "
        case .emailIsSignedBefore :
            return "This email address is already in use by another account  please go to login page "
        case .emptyFileds :
            return "You must fill all the Fields"
        case .signInError :
            return "The password is invalid or the user or the user is not exsist"
        }
        
    }
}
