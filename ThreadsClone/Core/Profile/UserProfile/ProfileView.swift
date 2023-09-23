//
//  ProfileView.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct ProfileView: View {
    let user : User
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            //bio and stats
            VStack(spacing:20) {
                ProfileHeaderView(user: user)
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
                UserContentListView()
                
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
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}
