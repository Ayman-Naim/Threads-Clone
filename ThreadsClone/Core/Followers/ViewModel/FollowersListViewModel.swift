//
//  FollowersListViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 23/01/2024.
//

import Foundation
class FollowersListViewModel:ObservableObject{
    
    @Published var following = [User]()
    @Published var followers = [User]()
    var currentuser  = UserService.shared.currentUser
    init() {
        Task{
            try await fetchUsers()
            print(followers)
        }
    }
    
    @MainActor
    func fetchUsers()async throws{
        let users  = try await UserService.fetchUsers()
        self.followers = users.filter({ user in
            return currentuser?.follwers?.contains(user.id)  ?? false
        })
        self.following = users.filter({ user in
            return currentuser?.following?.contains(user.id)  ?? false
        })
    }
    func refresh ()async throws{
        self.currentuser = UserService.shared.currentUser
        try await self.fetchUsers()
        
    }
}
