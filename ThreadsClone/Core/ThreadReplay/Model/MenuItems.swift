//
//  MenuItems.swift
//  ThreadsClone
//
//  Created by ayman on 19/01/2024.
//

import Foundation
enum MenuItems:String ,CaseIterable,Identifiable {
    case Edit
    case Delete
    var id : Self {return self}
    var title : String {
        switch self {
        case .Edit: return "Edit"
        case .Delete: return  "Delete" 
        }
    }
    
}
