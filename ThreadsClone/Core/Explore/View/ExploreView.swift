//
//  ExploreView.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @StateObject var viewModel = ExploreViewModel()
    @State var filterdArray : [User] = []
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack{
                    ForEach(searchText == "" ? viewModel.users:filterdArray) { user in
                        NavigationLink(value: user) {
                            VStack {
                                
                                UserCell(user: user)
                                Divider()
                            }
                            .padding(.vertical , 4)
                        }
                    }
                }.padding()
            }
           
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Search")
            .searchable(text: $searchText,prompt: "Search")
            .onChange(of: searchText) { newValue in
                
                filterdArray = viewModel.users.filter({ user in
                    user.userName.localizedCaseInsensitiveContains(newValue)
                })
              
            }
        }
        .onAppear{
            Task{
               try await  viewModel.fetchUsers()
            }
            
        }
        
        
        
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
