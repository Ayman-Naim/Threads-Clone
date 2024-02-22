//
//  PostCell.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct PostCell: View {
    @Binding var thread : Thread
    @State var replyClicked = false
    @StateObject  var viewModel : PostCellViewModel //= PostCellViewModel()
    @State var likeClicked = false
    var currentUser: User?
 
    @State var deleteThreadAlert  = false
    @Binding var threadsArray : [Thread]
    @State var settingButton =  true
    @State var editThread =  false
    init(thread : Binding <Thread> ,currentUser:User? , threadsArray : Binding<[Thread]>){
        self._viewModel = StateObject(wrappedValue: PostCellViewModel(currentUser: currentUser))
        self.currentUser  = currentUser
        self._thread = thread
        self._threadsArray = threadsArray
        
        }
    var body: some View {
        VStack{
            HStack(alignment: .top,spacing: 12)
            {
               
                CircularProfileImageView(user: thread.user,size: .small)
               
                VStack(alignment: .leading, spacing: 4){
                    HStack {
                        Text(thread.user?.userName ?? "")
                            .font(.footnote)
                            .fontWeight(.bold)
                        Spacer()
                        Text(thread.timeStamp.timeStampString())
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))
                            .tint(Color(UIColor(named: "TabColor") ?? .black))
                        
                      //  if thread.ownerUid == currentUser?.id{
                        Menu{
                          
                            Button{
                                editThread.toggle()
                                
                            }label: {
                                Label("Edit", systemImage: "pencil.line")
                            }
                            Button(role:.destructive){
                                deleteThreadAlert.toggle()
                            }label: {
                                Label("Delete", systemImage: "minus.circle")
                            }
                            
                        }label: {
                            Image(systemName: "ellipsis")
                                .tint(Color(UIColor(named: "TabColor") ?? .black))
                        }
                        .disabled(thread.ownerUid != currentUser?.id)
                      //  }
                        
                    }
                    
                    Text(thread.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    
                    HStack(spacing: 16){
                        
                        
                        Button{
                            likeClicked.toggle()
                            Task {
                              
                               
                               // print("LikedButton:",likeClicked)
                                thread.like(LikesUser: viewModel.Currentuser!.id, liked: likeClicked)
                                try await viewModel.LikeThread(thread, liked: likeClicked)
                                    
                            }
                            
                        }label: {

                            Image(systemName: likeClicked ? "suit.heart.fill":"heart")
                                
                               .foregroundColor(likeClicked ? .red:Color(UIColor(named: "TabColor") ?? .black))
                                .tint(Color(UIColor(named: "TabColor") ?? .black))
                            
                        }
                        
                        
                        
                        
                        
                        Button{
                            replyClicked.toggle()
                            
                        }label: {
                            Image(systemName: "bubble.right")
                            .foregroundColor(Color(UIColor(named: "TabColor") ?? .black))
                            
                        }
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "arrow.rectanglepath")
                                .foregroundColor(Color(UIColor(named: "TabColor") ?? .black))
                                
                            }
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "paperplane")
                                .foregroundColor(Color(UIColor(named: "TabColor") ?? .black))
                            }
                   
                           
                            
                        
                    }.foregroundColor(.black)
                        .padding(.vertical , 8 )
                        
                        
                    HStack(spacing: 3){
                        if thread.likes != 0{
                            Text("Likes:")
                            Text("\(thread.likes)")
                        }
                        if thread.repliesCount != 0 {
                            if thread.likes != 0 {
                                Text("-")
                            }
                            Text("replies")
                            Text("\(thread.repliesCount)")
                           
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
            }.onChange(of: likeClicked) { newValue in
               
            }
            
            Divider()
        }.padding()
            .sheet(isPresented: $replyClicked) {
                Replay(threadUser: $thread)
            }
            .sheet(isPresented: $editThread) {
                CreateThreadView(thread: $thread, edit: _editThread)
            }
            .alert(isPresented: $deleteThreadAlert) {
                
                Alert(title: Text("Delete Thread "),message: Text("Are you sure you want delete this thread ")
                      , primaryButton: .destructive(Text("Ok"),action: {
                    //
                 
                    Task{
                        try await viewModel.DeleteThread(thread: thread
                        )
                        if self.threadsArray.count == 1 {
                            self.threadsArray = []

                        }else {
                            self.threadsArray.removeAll{
                                $0.id == thread.id
                            }
                        }
                    }
                   
                   
                })
                      , secondaryButton: .cancel(Text("Cancel"))
                )
                
                
            }

            .onAppear{
                viewModel.Currentuser = UserService.shared.currentUser
                likeClicked = false
                if let id = viewModel.Currentuser?.id{
                    if  currentUser?.id != nil && ((thread.likesAcounts?.firstIndex(of:(id))) != nil){
                        likeClicked = true
                    }else{
                        likeClicked = false
                    }
                    
                }
            }
      
            
    }
        
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(thread: .constant(dev.thread), currentUser: dev.user, threadsArray: .constant([dev.thread]))
    }
}
