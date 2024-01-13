//
//  Timestamp.swift
//  ThreadsClone
//
//  Created by ayman on 13/01/2024.
//

import Foundation
import FirebaseFirestore
extension Timestamp {
    func timeStampString()->String{
        let formater = DateComponentsFormatter()
        formater.allowedUnits = [.second,.minute,.hour,.day,.weekOfMonth,.year]
        formater.maximumUnitCount = 1
        formater.unitsStyle = .abbreviated
        return formater.string(from: self.dateValue(),to: Date()) ?? ""
    }
}
