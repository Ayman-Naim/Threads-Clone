//
//  PostCellViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 18/01/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
class PostCellViewModel :ObservableObject{
    // @Published var thread : Thread?
    
//    init(thred : Thread ){
//        self.thread = thred
//    }
    @Published var Currentuser : User? = UserService.shared.currentUser
    
    func LikeThread(_ thread :  Thread,liked:Bool)async throws {
        let snapshot = try await Firestore.firestore().collection("threads").document(thread.threadId!).getDocument()
        let threadData = try snapshot.data(as: Thread.self)
        guard let userID = UserService.shared.currentUser?.id else { return }
        var likesArray = threadData.likesAcounts
        print("Debug likes",threadData)
        if liked {
            likesArray?.append(userID)
         //   thread.like( Likesusers: userID, liked: liked)
            try await Firestore.firestore().collection("threads").document(thread.threadId!).setData(["likesAcounts":likesArray!,"likes":threadData.likes+1],merge: true)
        }else{
            guard let userID = UserService.shared.currentUser?.id else { return }
            likesArray?.removeAll{$0 == userID}
            try await Firestore.firestore().collection("threads").document(thread.threadId!).setData(["likesAcounts":likesArray!,"likes":threadData.likes-1],merge: true)
        }
        
    }
    
    
    func DeleteThread(thread:Thread)async throws{
        guard let threadId  = thread.threadId else {return}
         try await Firestore.firestore().collection("threads").document(threadId).delete()
        
    }
}
