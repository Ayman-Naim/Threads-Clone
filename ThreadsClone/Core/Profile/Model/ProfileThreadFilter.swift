//
//  ProfileThreadFilter.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import Foundation
enum ProfileThreadFilter: Int ,CaseIterable,Identifiable{
   
    
    case threads
    case replies
    //case likes
    var title :String{
        //self mean the enum obj 
        switch self{
        case .threads: return "Threads"
        case .replies: return "Replies "
      //  case .likes: return "Like"
            
        }
    }
    
    var id:Int{ return self.rawValue }
}
