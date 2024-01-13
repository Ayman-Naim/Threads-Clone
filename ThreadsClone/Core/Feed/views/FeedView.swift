//
//  fiedView.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct FeedView: View {
    @StateObject  var viewModel = FeedViewModel()
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators:false){
                LazyVStack{
                    
                    ForEach(viewModel.threads){
                        thread in
                        PostCell(thread: thread)
                        
                    }
                }
                
                }
            .refreshable {
                Task{try await viewModel.fetchThreads()}
            }
            .navigationTitle("Threads")
            .navigationBarTitleDisplayMode(.inline)
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
