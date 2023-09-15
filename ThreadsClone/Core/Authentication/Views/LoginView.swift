//
//  LoginView.swift
//  ThreadsClone
//
//  Created by ayman on 08/09/2023.
//

import SwiftUI

struct LoginView: View {
   
    @StateObject var viewModel = LoginViewModel()
    @State private var showalert  = false
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Image("App-Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120,height: 120)
                
                VStack{
                    TextField("Enter Your Email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(ThreadsTextfiledModifires())
                    
                       
                    SecureField("Enter Your password", text: $viewModel.password)
                        .modifier(ThreadsTextfiledModifires())
                    
                       
                }
                
                NavigationLink{
                    Text("Forget pass")
                    
                }label: {
                    Text("Forget Password?")
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .padding(.vertical)
                        .padding(.trailing,20)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                    
                    
                }
                
                Button{
                    Task{
                     try await viewModel.Login()
                    }
                }label: {
                    Text("Login")
                        .modifier(ButtonsModifires())
                }
                .onReceive(viewModel.$error,perform:{ error in
                    if(error != nil ){
                        showalert.toggle()
                    }
                })
                .alert(isPresented:$showalert, content:{
                    Alert(
                        title: Text("Login Failed"),
                        message: Text(viewModel.error?.localizedDescription ?? ""),
                        dismissButton: .cancel(Text("OK"))
                        
                    )
                })
                Spacer()
                Divider()
                NavigationLink{
                   RegisterationView()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign UP")
                            .fontWeight(.heavy)
                    }
                    .foregroundColor(.black)
                    .font(.footnote)
                }.padding(.vertical,16)
                
            }
        }
    }
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}
