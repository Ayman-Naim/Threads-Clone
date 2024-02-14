//
//  ProfileHeaderView.swift
//  ThreadsClone
//
//  Created by ayman on 24/09/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State var  user : User?
    @State var showFollowList = false
    init (user :State <User?>){
        self._user = user
    }
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading,spacing: 12) {
                //full name and users
                VStack(alignment: .leading, spacing: 4){
                    Text(user?.fullName ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(user?.userName ?? "")
                        .font(.subheadline)
                }
                if  let bio = user?.bio{
                    Text(bio)
                        .font(.footnote)
                }
                Button{
                    showFollowList.toggle()
                }label: {
                    let folowers = "\(user?.follwers?.count ?? 0)"
                    Text("\(folowers) followres")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
            Spacer()
               
            CircularProfileImageView(user: user,size: .medium)
                
        }
        .sheet(isPresented: $showFollowList) {
          
                FollowersView(user: $user)
            
        }
        
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: State(initialValue: dev.user))
    }
}
