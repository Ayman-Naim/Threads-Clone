//
//  UserCell.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack{
           CircularProfileImageView()
            VStack(alignment:.leading){
                Text("mnameno_2012")
                .fontWeight(.semibold)
                
                Text(" ayman naim ")
        
            } .font(.footnote)
            Spacer()
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
        }.padding(.horizontal)
        
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
