//
//  ThreadDetailsVM.swift
//  ThreadsClone
//
//  Created by ayman on 19/02/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
class ThreadDetailsViewModle:ObservableObject{
    @Published var replays : Thread?
    
    init(thread:Thread){
        Task{
            try await self.getReplays(thread: thread)
        }
    }
    @MainActor
    func getReplays(thread:Thread)async throws{
        let snapshot = try await Firestore.firestore().collection("threads").document(thread.threadId!).getDocument()
        var threadData = try  snapshot.data(as: Thread.self)
        
        for index in 0..<threadData.repliesCount{
            let user = try await UserService.fetchUser(withUid: (threadData.replys?[index].replayUserId)!)
            threadData.repliesAccounts?.append(user)
        }
        self.replays = threadData
        
        
    }
    func Refresh(thread : inout Thread){
        thread.repliesAccounts = self.replays?.repliesAccounts
        thread.replys = self.replays?.replys
        thread.repliesCount = self.replays!.repliesCount
    }
}
