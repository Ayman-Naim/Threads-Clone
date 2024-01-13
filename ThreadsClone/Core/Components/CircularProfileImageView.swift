//
//  CircularPrifileImageView.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI
import Kingfisher
struct CircularProfileImageView: View {
    let user:User?
    let size:ProfileImageSize
   
    var body: some View {
        if let imageUrl = user?.profileImageUrl{
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimention, height: size.dimention)
                .clipShape(Circle())
        }
        else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: size.dimention, height: size.dimention)
                .clipShape(Circle())
        }
        
    }
}

struct CircularPrifileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: dev.user,size: .medium)
    }
}



enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimention : CGFloat {
        switch self {
        case.xSmall : return 23
        case .xxSmall:return 32
        case .small: return 40
        case .medium: return 48
        case .large:return 64
        case .xLarge:
            return 80
        }
    }
}
