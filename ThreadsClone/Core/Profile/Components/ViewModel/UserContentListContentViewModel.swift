//
//  UserContentListContentViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 13/01/2024.
//

import Foundation
class UserContentListContentViewModel :ObservableObject {
    @Published var threads = [Thread]()
        
    let user : User
    init(user: User){
        self.user = user
        Task{try await fetchUserThreads()}
    }
    @MainActor
    func fetchUserThreads()async throws {
        self.threads.removeAll()
        var threads =  try await ThreadService.fetchUserThreads(uid: user.id)
        
        
        for i in  0 ..< threads.count{
            threads[i].user =  self.user
         
        }
        self .threads =  threads
    }
    
    
}
