//
//  LoginViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 16/09/2023.
//

import Foundation
import SwiftUI
import Foundation
class LoginViewModel:ObservableObject{
    @Published var error :Error?
    @Published  var email = ""
    @Published  var password = ""
    
    
    @MainActor
    func Login () async throws{
        do{
          
            try await AuthService.shared.login(
                
                withEmail: email,
                password: password
                
            )
          
        }catch {
            self.error = error
            
        }
        
    }
    
    
    
}
