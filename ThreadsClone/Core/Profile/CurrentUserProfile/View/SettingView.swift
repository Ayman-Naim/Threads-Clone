//
//  SettingView.swift
//  ThreadsClone
//
//  Created by ayman on 22/09/2023.
//

import SwiftUI

struct SettingView: View {
    @State private var showAlert = false
    @Environment(\.openURL) var openURL
    var body: some View {
        NavigationStack{
          
            List{
                HStack{
                    Image(systemName: "bell")
                    Text("Notifications")
                        .font(.headline)
                        .fontWeight(.light)
                    
                    
                    
                }
                
                HStack{
                    Image(systemName: "bell")
                    Text("Privacy")
                        .font(.headline)
                        .fontWeight(.light)
                }
                HStack{
                   
                            Image(systemName: "person.circle")
                            Text("Account")
                                .font(.headline)
                                .fontWeight(.light)
                        
                    
                }
                
                
                HStack{
                    Link(destination:URL(string: "https://help.instagram.com/788669719351544")!){
                        HStack{
                            Image(systemName: "questionmark.circle")
                            Text("Help")
                                .font(.headline)
                                .fontWeight(.light)
                        }
                    }
             
                }.foregroundColor(Color("BlackSystem"))
                
                    
                
                HStack{
                    Link(destination:URL(string: "https://help.instagram.com/788669719351544")!){
                        HStack{
                            Image(systemName: "exclamationmark.circle")
                            Text("About")
                                .font(.headline)
                                .fontWeight(.light)
                        }
                        
                    }
                }.foregroundColor(Color("BlackSystem"))
                
                
                Section{
                    Button{
                        showAlert.toggle()
                       
                    }label: {
                        Text("Log Out")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showAlert ,content: {
                        Alert(
                            title:  Text("Log Out"),
                            message: Text("Are you sure you want to log out"),
                            primaryButton:.destructive(Text("Log Out"),action: {
                                AuthService.shared.SignOut()
                            }),
                            secondaryButton: .cancel(Text("Cancel"))
                        )
                    })
                }
                
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
