//
//  FeedViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 13/01/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
@MainActor
class FeedViewModel:ObservableObject {
    @Published var threads = [Thread]()
    @Published var currentUser:User?
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        Task{
            fetchUser()
            try await fetchThreads()}
       
      
    }
    
    
    func fetchThreads () async throws {
        self.threads.removeAll()
        self.threads = try await ThreadService.fetchThreads()
        try await fetchUserDataForThreads()
    }
    private func fetchUserDataForThreads() async throws{
        for i in 0..<threads.count {
            let thread = threads[i]
            let ownerUid = thread.ownerUid
            let  threadUser = try await UserService.fetchUser(withUid: ownerUid)
            threads[i].user = threadUser
        }
    }
    @MainActor
    func fetchUser(){
        UserService.shared.$currentUser.sink{ [weak self ] user in
            DispatchQueue.main.async {
                self?.currentUser = user
            }
            
           
            print("DEBUG: user in view model from combine is \(user)")
        }.store(in:&cancellable)
    }
  
}
