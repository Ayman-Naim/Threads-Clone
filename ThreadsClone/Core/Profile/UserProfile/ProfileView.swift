//
//  ProfileView.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct ProfileView: View {
    let user : User
    var viewModel : ProfilViewModel
    @State var isFollowed = false
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfilViewModel()
        self.isFollowed = viewModel.isFollowed(user: user)
        }
   
    var body: some View {
        
        ScrollView(showsIndicators: false){
            //bio and stats
            VStack(spacing:20) {
                ProfileHeaderView(user: State(initialValue: user))
                Button{
                    isFollowed.toggle()
                    Task{
                        try await viewModel.follow(user:user ,Isfollow:isFollowed)
                    }
                }label: {
                   
                    Text(isFollowed  ? "Following":"Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                       // .foregroundColor(viewModel.isFollowed == false ? .white:.gray)
                        .frame(width: 352, height: 32)
                        .overlay{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isFollowed ?  Color(.systemGray4) :.black, lineWidth: 1)
                        }
                        .foregroundColor(isFollowed ? .gray:.black)
//                        .cornerRadius(8)
                       
                    
                }
                
                //user content list view
                UserContentListView(user: user)
                
            }
           // not needed in  other user navgation profile
           /* .toolbar{
                ToolbarItem(placement:.navigationBarTrailing){
                    NavigationLink{
                        SettingView()
                    }label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }*/
        }
              
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .onAppear{

            self.isFollowed = viewModel.isFollowed(user: user)

        }
     
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}
