//
//  ActivityView.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct ActivityView: View {
    @State var SelectedFilter = 0
    @State var threads = [Thread]()
    @StateObject var viewModel : NotficationViewModel = NotficationViewModel()
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    Text("Activity")
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    
                    Picker("Selected Filter", selection: $SelectedFilter){
                        Text("All").tag(0)
                        Text("Replied").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .frame(width:UIScreen.main.bounds.width/2 ,height: 30)
                    
                    .onAppear{
                        UISegmentedControl.appearance().selectedSegmentTintColor = .black
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
                    }
                    .onChange(of: SelectedFilter){ FilterValue in
                        print(FilterValue)
                        
                    }
                    
                    ForEach(0..<viewModel.notificatons.count,id: \.self){ index in
                        NavigationLink{
                            switch viewModel.notificatons[index].notifcatonType{
                            case .replay,.like:
                                
                                ThreadDetailsView(thread: ($viewModel.notificatons[index].threadRef.toUnwrapped(defaultValue:viewModel.notificatons[index].threadRef! )) , user:$viewModel.notificatons[index].fromUser , threadsArray: $threads)
                            case.follow:
                                ProfileView(user: viewModel.notificatons[index].fromUser!)
                            
                            }
                            
                        }label: {
                           
                                NotificationCell(user: viewModel.notificatons[index].fromUser!, notification: $viewModel.notificatons[index])
                                Divider()
                            
                        }
                    }
                }
               
                }
            .padding(.leading)
            .navigationTitle("Activity")
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                Task{
                    try await viewModel.getNotfications()
                }
            }
            .onAppear{
                Task{
                    try await viewModel.getNotfications()
                }
            }
        }
        
        
       
    }
    
   
}
extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
