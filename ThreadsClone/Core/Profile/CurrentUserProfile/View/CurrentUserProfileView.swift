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
    private var filterBarWidth:CGFloat{
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }
    
    private var currentUser:User?{
        return viewModel.currentUser
    }
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                //bio and stats
                VStack(spacing:20) {
                    ProfileHeaderView(user: currentUser)
                    Button{
                            
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
                    UserContentListView()
                    
                }
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
    }
}

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView()
    }
}
