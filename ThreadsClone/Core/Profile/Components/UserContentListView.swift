//
//  UserContentListView.swift
//  ThreadsClone
//
//  Created by ayman on 24/09/2023.
//

import SwiftUI

struct UserContentListView: View {
    @State private var selectedFilter :ProfileThreadFilter = .threads
    @Namespace var animation
    private var filterBarWidth:CGFloat{
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }
    var body: some View {
        VStack{
            HStack{
                ForEach(ProfileThreadFilter.allCases){filter in
                    VStack{
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter==filter ? .semibold : .regular)
                        
                        if selectedFilter == filter{
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width:filterBarWidth ,height: 1)
                                .matchedGeometryEffect(id: "itme", in: animation)
                        }
                        else{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width:filterBarWidth ,height: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring())
                        {
                            selectedFilter = filter
                        }
                    }
                }
            }
            LazyVStack{
                ForEach(0 ... 10 ,id:\.self){thread in
                    PostCell()
                }
            }
        }.padding(.vertical,8)

    }
}

struct UserContentListView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentListView()
    }
}
