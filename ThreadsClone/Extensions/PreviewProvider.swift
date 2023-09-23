//
//  PreviewProvider.swift
//  ThreadsClone
//
//  Created by ayman on 23/09/2023.
//

import Foundation
import SwiftUI

extension PreviewProvider{
    static var dev :DeveloperPreview{
        return DeveloperPreview.shared
    }
}

class DeveloperPreview{
    static let shared = DeveloperPreview()
    
    
    let user = User(id: NSUUID().uuidString, fullName: "ayman Moahemd", email: "manameno_2012@yahoo.com", userName: "mnameno")
    
    
}
