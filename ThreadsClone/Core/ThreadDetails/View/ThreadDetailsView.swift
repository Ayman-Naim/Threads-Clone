//
//  ThreadDetailsView.swift
//  ThreadsClone
//
//  Created by ayman on 19/02/2024.
//

import SwiftUI

struct ThreadDetailsView: View {
    @Binding var thread : Thread
    @Binding var user:User?
    @Binding var threadsArray : [Thread]
    @StateObject var viewModel :ThreadDetailsViewModle
    
    init(thread: Binding<Thread>, user: Binding<User?>, threadsArray: Binding<[Thread]>) {
        self._thread = thread
        self._user = user
        self._threadsArray = threadsArray
        self._viewModel =  StateObject(wrappedValue: ThreadDetailsViewModle(thread: thread.wrappedValue))
       
    }
    var body: some View {
        NavigationStack{
            VStack(spacing: 10){
                PostCell(thread:$thread , currentUser: user, threadsArray: $threadsArray)
                
                ScrollView{
                    LazyVStack{
                        ForEach(0..<(viewModel.replays?.repliesAccounts?.count ?? 0) ,id: \.self){ index in
                            ReplayCell(replay: viewModel.replays?.replys?[index], user: viewModel.replays?.repliesAccounts?[index])
                            
                        }
                        
                        
                        
                    }.padding()
                }
            }
            .navigationTitle("Thread")
            .navigationBarTitleDisplayMode(.inline)
            }
        }
    }


struct ThreadDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ThreadDetailsView(thread: .constant(dev.thread), user:
                .constant(dev.user), threadsArray: .constant([dev.thread]))
    }
}
