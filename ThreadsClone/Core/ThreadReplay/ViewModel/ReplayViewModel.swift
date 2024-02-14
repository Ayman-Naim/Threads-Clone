//
//  ReplayViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 14/02/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ReplayViewModel{
    
    @Published var currentUser = UserService.shared.currentUser
    func ReplayThread(replay:String , thread:Thread)async throws{
        let snapshot = try await Firestore.firestore().collection("threads").document(thread.threadId!).getDocument()
        var threadData = try snapshot.data(as: Thread.self)
        // make array of replyies which can be same user with more one replay 
    }
}
