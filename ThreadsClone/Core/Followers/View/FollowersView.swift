//
//  FollowersView.swift
//  ThreadsClone
//
//  Created by ayman on 23/01/2024.
//

import SwiftUI

struct FollowersView: View {
    @State var selectedFilter :FollowingFilter = .followers
    @Namespace var animation
    @Binding var user : User?
    @StateObject var viewModel  =  FollowersListViewModel()
    private var filterBarWidth: CGFloat{
        let count = CGFloat(FollowingFilter.allCases.count)
        return UIScreen.main.bounds.width/count - 16
    }
    
    var body: some View {
        VStack{
            HStack{
                ForEach(FollowingFilter.allCases){filter in
                    VStack{
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold:.regular)
                        if selectedFilter  == filter{
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: filterBarWidth, height: 1)
                        }
                        else{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: filterBarWidth, height: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()){
                            selectedFilter = filter
                        }
                }
            }
        }
            
           
                NavigationStack{
                    ScrollView{
                        VStack{
                            selectedFilter == FollowingFilter.followers ?
                            Text("\(String(user?.follwers?.count ?? 0)) \(selectedFilter.title)"):Text("\(String(user?.following?.count ?? 0)) \(selectedFilter.title)")
                               
                        }
                        .font(.caption)
                        .foregroundColor(.gray)
                    LazyVStack{
                        
                        ForEach(selectedFilter == FollowingFilter.followers ? viewModel.followers:viewModel.following){ user in
                            NavigationLink(value:user){
                                VStack{
                                    UserCell(user: user)
                                    Divider()
                                }
                                .padding(.vertical,4)
                            }
                            
                        }
                    }
                    .navigationDestination(for: User.self, destination: {user in
                        ProfileView(user: user)
                        
                    })
                }
            }
                .onAppear{
                    Task{
                        try await  viewModel.refresh()
                        Task{
                            self.user = try await UserService.fetchUser(withUid: user!.id)
                        }
                    
                    }
                }
        }.padding()
    }
}

struct FollowersView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersView( user: .constant (dev.user))
    }
}
