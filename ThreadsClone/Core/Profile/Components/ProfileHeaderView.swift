//
//  ProfileHeaderView.swift
//  ThreadsClone
//
//  Created by ayman on 24/09/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user : User?
    
    init (user :User?){
        self.user = user
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
                Text("2 followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            CircularProfileImageView()
            
            
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: dev.user)
    }
}
