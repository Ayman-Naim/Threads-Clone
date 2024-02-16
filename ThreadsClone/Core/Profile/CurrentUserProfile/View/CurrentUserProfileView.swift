//
//  CurrentUserProfileView.swift
//  ThreadsClone
//
//  Created by ayman on 24/09/2023.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var selectedFilter :ProfileThreadFilter = .threads
    @Namespace var animation
    @State private var showEditProfile =  false
    
     private var filterBarWidth:CGFloat{
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }
    
//     private var currentUser:User?{
//        return UserService.shared.currentUser
//    }
    @State var currentUser : User? = UserService.shared.currentUser
 
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                //bio and stats
                VStack(spacing:20) {
                    ProfileHeaderView(user:  _currentUser)
                    Button{
                        showEditProfile.toggle()
                    }label: {
                            Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(width: 352, height: 32)
                            .background(.white)
                            .cornerRadius(8)
                            .overlay{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                    
                    //user content list view
                    if let user = currentUser{
                        UserContentListView(user: user)
                    }
                }.sheet(isPresented: $showEditProfile, content: {
                    if let user =  currentUser{
                        EditProfileView(user: user)
                    }
                })
                
                .toolbar{
                    ToolbarItem(placement:.navigationBarTrailing){
                        NavigationLink{
                            SettingView()
                        }label: {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                }
            }.padding(.horizontal)
            
        }
        .onAppear{
            Task{
               try await  viewModel.setProfileData()
                self.currentUser = UserService.shared.currentUser
            }
           
            }
        .refreshable{
            Task{
               try await  viewModel.setProfileData()
                self.currentUser = UserService.shared.currentUser
            }
            
            
        }
        
    }
}

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView()
    }
}
