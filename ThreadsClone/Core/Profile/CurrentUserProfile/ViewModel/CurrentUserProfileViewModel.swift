//
//  CurrentUserProfileViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 24/09/2023.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI


class CurrentUserProfileViewModel :ObservableObject {
    @Published var currentUser :User?
   
   
    private var cancellable = Set<AnyCancellable>()
    init(){
        Task{
            try await setProfileData()
        }
    }
       @MainActor
     func setProfileData()async throws {
       try await UserService.shared.fetchCurrentUser()
        UserService.shared.$currentUser.sink{ [weak self ] user in
            DispatchQueue.main.async {
                self?.currentUser = user
            }
            
            print("DEBUG: user in view model from combine is \(user)")
        }.store(in:&cancellable)
        
    }

    
    
    
    
    
}
