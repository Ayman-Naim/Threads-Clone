//
//  UserCell.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct UserCell: View {
    let user : User
    @State var isFollowed = false
    @StateObject var viewModel = UserCellViewModel()
    var body: some View {
        HStack{
            CircularProfileImageView(user: user,size: .small)
            VStack(alignment:.leading,spacing: 2){
                Text(user.userName)
                    .fontWeight(.semibold)
                
                Text(user.fullName)
                
            } .font(.footnote)
            Spacer()
            Button{
                isFollowed.toggle()
                Task{
                    try await viewModel.follow(user:user,Isfollow:isFollowed)
                }
            }label: {
                
                Text(isFollowed == false ? "Follow":"UnFollow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 32)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
                    .foregroundColor(isFollowed ? .gray:.black)
//                    .background(isFollowed ? .black:.clear)
            }.padding(.horizontal)
            
        }
        .onAppear{
            
            self.isFollowed = viewModel.isfollowed(user: user)
           
        }
      
       
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: dev.user)
    }
}
