//
//  CreateThreadViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 13/01/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class CreateThreadViewModel:ObservableObject{
  
    func uploadThread(caption:String)async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return }
        let thread = Thread(ownerUid: uid, timeStamp: Timestamp(), caption: caption, likes: 0,likesAcounts: [],repliesCount: 0,repliesAccounts: [])
        try await  ThreadService.uploadThread(thread)
    }
    
    
    func UpdateThread(caption:String,thread: Thread)async throws {
      
            let snapshot = try await Firestore.firestore().collection("threads").document(thread.threadId!).getDocument()
            let threadData = try snapshot.data(as: Thread.self)
            try await Firestore.firestore().collection("threads").document(thread.threadId!).setData(["caption":caption],merge: true)
         

    }
}
