//
//  Replay.swift
//  ThreadsClone
//
//  Created by ayman on 19/01/2024.
//

import SwiftUI

struct Replay: View {
   
    @Binding var threadUser : Thread
    @State var replay  = ""
    @Environment(\.dismiss) var dismiss 
    private var CurrentUser: User? {
        return UserService.shared.currentUser
    }
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                HStack(alignment: .top,spacing: 12){
                    CircularProfileImageView(user: threadUser.user, size: .small)
                    VStack(alignment:.leading,spacing: 4){
                        Text(threadUser.user?.userName ?? "userName" )
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text(threadUser.caption)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                
                HStack{
                    

                    
                    Rectangle()
                        .fill(.secondary)
                        .frame(width: 2.4)
                        .edgesIgnoringSafeArea(.horizontal)
                  
                } .frame(width: 40, height: 40)
              
                VStack{
                    HStack(alignment: .top,spacing: 12){
                        CircularProfileImageView(user: CurrentUser, size: .small)
                        VStack(alignment:.leading,spacing: 4){
                            Text(CurrentUser?.userName ?? "userName")
                                .font(.footnote)
                                .fontWeight(.semibold)
                            TextField("Replay", text: $replay,axis: .vertical)
                        }
                        
                    }
                }.font(.footnote)
                Spacer()
            }.padding()
                .navigationBarTitle("Replay")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement:.navigationBarLeading){
                        Button("Canel"){
                            dismiss()
                        }.font(.subheadline)
                            .foregroundColor(.black)
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Reply"){
                            dismiss()
                        }
                        .opacity(replay.isEmpty ? 0.5:1)
                        .disabled(replay.isEmpty)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    }
                }
            
            
        }
    }
}

struct Replay_Previews: PreviewProvider {
    static var previews: some View {
        Replay(threadUser: .constant( dev.thread))
    }
}
