//
//  NotficationViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 18/02/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
class NotficationViewModel:ObservableObject{
    @Published var notificatons : [NotficationModel] = []
    
    init() {
        Task{
           try await self.getNotfications()
        }
    }
    @MainActor
    func getNotfications()async throws{
        guard let currentUser = UserService.shared.currentUser else {return}
        let snapshot = try await Firestore.firestore().collection("Notification").document(currentUser.id).getDocument()
      
        var notifications = try  snapshot.data(as: Notfictation.self)
        
        for index in 0..<notifications.notifications.count{
            notifications.notifications[index].fromUser = try await UserService.fetchUser(withUid: notifications.notifications[index].fromUserID)
        }
        notifications.notifications.sort{$0.timeStamp>$1.timeStamp}
        self.notificatons.removeAll()
        self.notificatons = notifications.notifications
        
       // print(notificatons,"nonoooe")
    }
}
