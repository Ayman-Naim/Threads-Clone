//
//  ProfileView.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
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
                    HStack(alignment: .top) {
                        VStack(alignment: .leading,spacing: 12) {
                            //full name and users
                            VStack(alignment: .leading, spacing: 4){
                                Text(currentUser?.fullName ?? "")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Text(currentUser?.userName ?? "")
                                    .font(.subheadline)
                            }
                            if  let bio = currentUser?.bio{
                                Text(bio)
                                    .font(.footnote)
                            }
                            Text("2 followers")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        CircularProfileImageView()
                        
                     
                    }
                    Button{
                            
                    }label: {
                            Text("Follow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 352, height: 32)
                            .background(.black)
                            .cornerRadius(8)
                    }
                    
                    //user content list view
                    VStack{
                        HStack{
                            ForEach(ProfileThreadFilter.allCases){filter in
                                VStack{
                                    Text(filter.title)
                                        .font(.subheadline)
                                        .fontWeight(selectedFilter==filter ? .semibold : .regular)
                                    
                                    if selectedFilter == filter{
                                        Rectangle()
                                            .foregroundColor(.black)
                                            .frame(width:filterBarWidth ,height: 1)
                                            .matchedGeometryEffect(id: "itme", in: animation)
                                    }
                                    else{
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width:filterBarWidth ,height: 1)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.spring())
                                    {
                                        selectedFilter = filter
                                    }
                                }
                            }
                        }
                        LazyVStack{
                            ForEach(0 ... 10 ,id:\.self){thread in
                                PostCell()
                            }
                        }
                    }.padding(.vertical,8)
                    
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
