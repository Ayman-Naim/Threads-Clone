//
//  ContentViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 15/09/2023.
//

import Foundation
import Combine
import FirebaseAuth

class ContentViewModell:ObservableObject{
    @Published var userSession:FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        SetupSubscribers()
    }
    
    private func SetupSubscribers(){
        AuthService.shared.$userSessoion.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
        
    }
}
