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
     var thread : Thread?
    
    init(thred : Thread ){
        self.thread = thred
    }
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
}
