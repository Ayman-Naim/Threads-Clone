//
//  ReplayCell.swift
//  ThreadsClone
//
//  Created by ayman on 19/02/2024.
//

import SwiftUI

struct ReplayCell: View {
    @State var replay : ThreadReplay?
    @State var user : User?
    var body: some View {
        HStack(alignment: .top,spacing: 12){
            CircularProfileImageView(user:user, size: .small)
            VStack(alignment:.leading,spacing: 4){
                Text(user?.userName ?? "userName" )
                    .font(.footnote)
                    .fontWeight(.semibold)
              
                Text(replay?.replay ?? "11")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                Spacer()
                Divider()
            }
           
            Spacer()
            
        }
    }
}

struct ReplayCell_Previews: PreviewProvider {
    static var previews: some View {
        ReplayCell(user: dev.user)
    }
}
