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
    @StateObject var viewModel : ReplayViewModel
    @Environment(\.dismiss) var dismiss
    @State private var scrollToLast = false
    @Namespace var bottomID
    private var CurrentUser: User? {
        return UserService.shared.currentUser
    }
    init(threadUser : Binding <Thread>){
        self._viewModel = StateObject(wrappedValue: ReplayViewModel(thread: threadUser.wrappedValue))
        self._threadUser = threadUser

        }
    var body: some View {
        NavigationStack{
            ScrollViewReader { scrollView in
                ScrollView{
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
                        
                       /* HStack{
                            
                        
                            
//                            Rectangle()
//                                .fill(.secondary)
//                                .frame(width: 2.4)
//                                .edgesIgnoringSafeArea(.horizontal)
                            
                        } .frame(width: 40, height: 40)*/
                        Divider()
                        
                        
                        ForEach(0..<(viewModel.replays?.repliesAccounts?.count ?? 0) ,id: \.self){ index in
                            HStack(alignment: .top,spacing: 12){
                                CircularProfileImageView(user: viewModel.replays?.repliesAccounts?[index], size: .small)
                                VStack(alignment:.leading,spacing: 4){
                                    Text(viewModel.replays?.repliesAccounts?[index].userName ?? "userName" )
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                  
                                    Text(viewModel.replays?.replys?[index].replay ?? "11")
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
                            
                        }
                        
                        
                        .onChange(of: scrollToLast) { newValue in
                            self.scrollToLast = false
                            scrollView.scrollTo(bottomID)
                            
                        }
                        
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
                            .id(bottomID)
                        }.font(.footnote)
                        Spacer()
                    }.padding()
                        .navigationBarTitle("Replay")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement:.navigationBarLeading){
                                Button("Cancel"){
                                    dismiss()
                                }.font(.subheadline)
                                    .foregroundColor(.black)
                                
                            }
                            ToolbarItem(placement: .navigationBarTrailing){
                                Button("Reply"){
                                    Task{
                                        do {
                                            try await viewModel.ReplayThread(replay: replay, thread: threadUser)
                                            self.replay = ""
                                            scrollToLast = true
                                        }
                                        catch{
                                            
                                        }
                                    
                                    }
                                    
                                    
                                    
                                    
                                    //dismiss()
                                }
                                .opacity(replay.isEmpty ? 0.5:1)
                                .disabled(replay.isEmpty)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            }
                        }
                }}
                .onDisappear{
                    viewModel.Refresh(thread: &threadUser)
                }
               
            
        }
    }
}

struct Replay_Previews: PreviewProvider {
    static var previews: some View {
        Replay(threadUser: .constant( dev.thread))
    }
}
