//
//  PostCell.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct PostCell: View {
    var body: some View {
        VStack{
            HStack(alignment: .top,spacing: 12)
            {
                CircularProfileImageView()
                
                VStack(alignment: .leading, spacing: 4){
                    HStack {
                        Text("aymanNaim")
                            .font(.footnote)
                        .fontWeight(.bold)
                        Spacer()
                        Text("10m")
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))
                        Button{
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                            
                        }
                        
                    }
                    
                    Text("what are uou dong today")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16){
                        Button{
                            
                        }label: {
                            Image(systemName: "heart")
                                
                        }
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "bubble.right")
                        }
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "paperplane")
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
        PostCell()
    }
}
