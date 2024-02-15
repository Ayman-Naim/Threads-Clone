//
//  fiedView.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct FeedView: View {
    @StateObject  var viewModel = FeedViewModel()
    
    private var currentUser:User?{
        return viewModel.currentUser
    }
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators:false){
                LazyVStack{
                    
                    ForEach($viewModel.threads){
                        thread in
                        PostCell(thread: thread,currentUser: currentUser ?? nil, threadsArray: $viewModel.threads)
                        
                    }
                }
                
                }
            .refreshable {
                Task{try await viewModel.fetchThreads()}
            }
            .navigationTitle("Threads")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear{
            
            
            Task{
                
                try await viewModel.fetchThreads()
               
                
            }
        }
    
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    
                }label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(.black)
                }
            }
        }
    }
        
}

struct fiedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            FeedView()
        }
    }
}
