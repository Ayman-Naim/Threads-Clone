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
    @Published var Currentuser : User? = UserService.shared.currentUser
    init(currentUser : User?){
        self.Currentuser = Currentuser
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
            // notification
            let notfication = NotficationModel(notifcatonType: .like, fromUserID: (Currentuser?.id)!, noticationStatus:.unRead, refrence: thread.id, timeStamp: Timestamp())
            let notficationData: [String: Any] = [
                "id": notfication.id,
                "notifcatonType": notfication.notifcatonType.rawValue ,
                "fromUserID": notfication.fromUserID,
                "noticationStatus":notfication.noticationStatus.rawValue,
                "timeStamp":notfication.timeStamp,
                "refrence":notfication.refrence
            ]
            
            try await Firestore.firestore().collection("Notification").document(thread.ownerUid).setData(["notifications": FieldValue.arrayUnion([notficationData])],merge: true)
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
