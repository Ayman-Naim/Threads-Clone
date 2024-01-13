//
//  PostCell.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct PostCell: View {
    let thread : Thread
    
    @State var likeClicked = false
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
                        Text(thread.timeStamp.timeStampString() )
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
                            
                        }label: {
                            
                            Image(systemName: likeClicked ? "suit.heart.fill":"heart")
                                
                               .foregroundColor(likeClicked ? .red:Color(UIColor(named: "TabColor") ?? .black))
                                .tint(Color(UIColor(named: "TabColor") ?? .black))
                            
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
                }
            }
            
            Divider()
        }.padding()
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(thread: dev.thread)
    }
}
