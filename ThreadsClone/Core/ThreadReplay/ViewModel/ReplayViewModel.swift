//
//  ReplayViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 14/02/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ReplayViewModel:ObservableObject{
    
    @Published var currentUser :User?
    @Published var replays : Thread?
   
    init(thread:Thread) {
        self.currentUser = UserService.shared.currentUser
        self.replays = thread
        Task{
            try await self.getReplays(thread: thread)
        }
    }
    @MainActor
    func ReplayThread(replay:String , thread:Thread)async throws{
        let snapshot = try await Firestore.firestore().collection("threads").document(thread.threadId!).getDocument()
        var threadData = try snapshot.data(as: Thread.self)
        // append replays to thread
        guard let currentUser = currentUser else{return }
        
        let newReplay = ThreadReplay(replay: replay, replayUserId: currentUser.id, timeStamp: Timestamp())
        var updatedReplies = threadData.replys ?? []
        
        let replayData: [String: Any] = [
                   "id": newReplay.id,
                   "replay": newReplay.replay,
                   "replayUserId": newReplay.replayUserId,
                   "timeStamp":newReplay.timeStamp
               ]
 // replay
        try await Firestore.firestore().collection("threads").document(thread.threadId!).updateData(["replys": FieldValue.arrayUnion([replayData]),"repliesCount": FieldValue.increment(Int64(1))])
 // notfication
        let notfication = NotficationModel(notifcatonType: .replay, fromUserID: newReplay.replayUserId, noticationStatus:.unRead, timeStamp: Timestamp())
        let notficationData: [String: Any] = [
            "id": notfication.id,
            "notifcatonType": notfication.notifcatonType.rawValue ,
            "fromUserID": notfication.fromUserID,
            "noticationStatus":notfication.noticationStatus.rawValue,
            "timeStamp":notfication.timeStamp
        ]
        
        try await Firestore.firestore().collection("Notification").document(thread.ownerUid).setData(["notifications": FieldValue.arrayUnion([notficationData])],merge: true)
// update user
        if replays?.repliesAccounts == nil{
            replays?.repliesAccounts = []
        }
        self.replays?.repliesAccounts?.append(currentUser)
        self.replays?.replys?.append(newReplay)
        self.replays?.repliesCount += 1
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
