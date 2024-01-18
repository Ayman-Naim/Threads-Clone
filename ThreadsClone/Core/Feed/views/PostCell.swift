//
//  PostCell.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct PostCell: View {
    var thread : Thread
    
    @StateObject  var viewModel : PostCellViewModel
    @State var likeClicked = false
    var currentUser: User?
 
    
    init(thread : Thread  ,currentUser:User?){
        self._viewModel = StateObject(wrappedValue: PostCellViewModel(thred: thread))
        self.currentUser = currentUser
        self.thread = thread
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
                        Button{
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .tint(Color(UIColor(named: "TabColor") ?? .black))
                            
                        }
                        
                    }
                    
                    Text(thread.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    
                    HStack(spacing: 16){
                        Button{
                            likeClicked.toggle()
                            print("LikedButton:",likeClicked)
                            viewModel.thread?.like(LikesUser: currentUser!.id, liked: likeClicked)
                           
                            Task {
                                try await viewModel.LikeThread(thread, liked: likeClicked)
                                    
                            }
                            
                        }label: {

                            Image(systemName: likeClicked ? "suit.heart.fill":"heart")
                                
                               .foregroundColor(likeClicked ? .red:Color(UIColor(named: "TabColor") ?? .black))
                                .tint(Color(UIColor(named: "TabColor") ?? .black))
                            
                        } .onAppear{
                          
                            if ((viewModel.thread?.likesAcounts?.firstIndex(of:(currentUser?.id)! )) != nil){
                                likeClicked = true
                            }else{
                                likeClicked = false
                            }
                        }
                        
                        Button{
                            
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
                        if viewModel.thread?.likes != 0{
                            Text("Likes:")
                            Text("\(viewModel.thread!.likes)")
                        }
                        if viewModel.thread?.repliesCount != 0 {
                            Text("-")
                            Text("replies")
                            Text("\(viewModel.thread!.repliesCount)")
                           
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
            }.onChange(of: likeClicked) { newValue in
               
            }
            
            Divider()
        }.padding()
            
    }
   /* mutating func ThreadLiked(){
        self.thread.like(LikesUser: (currentUser?.id)!, liked: likeClicked)
    }*/
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(thread: dev.thread, currentUser: dev.user)
    }
}
