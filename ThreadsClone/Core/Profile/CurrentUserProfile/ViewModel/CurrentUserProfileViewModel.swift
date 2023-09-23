//
//  CurrentUserProfileViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 24/09/2023.
//

import Foundation
import Combine


class CurrentUserProfileViewModel :ObservableObject {
    @Published var currentUser :User?
    private var cancellable = Set<AnyCancellable>()
    init(){
        setProfileData()
    }
       
    private func setProfileData(){
        UserService.shared.$currentUser.sink{ [weak self ] user in
            self?.currentUser = user
            print("DEBUG: user in view model from combine is \(user)")
        }.store(in:&cancellable)
        
    }
    
    
    
    
    
}
