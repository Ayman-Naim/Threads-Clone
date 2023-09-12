//
//  RegisterationView.swift
//  ThreadsClone
//
//  Created by ayman on 08/09/2023.
//

import SwiftUI

struct RegisterationView: View {
    @StateObject var viewModel = RegisterationViewModel()
   @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
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
                
                TextField("Enter Your Full name", text: $viewModel.fullName)
                    .modifier(ThreadsTextfiledModifires())
                
                TextField("Enter Your username", text: $viewModel.userName)
                    .modifier(ThreadsTextfiledModifires())
                
                
            }
            
            Button{
                Task{ try await viewModel.CreateUser()}
                    
            }label: {
                Text("SignUp")
                    .modifier(ButtonsModifires())
                
            }
            .onReceive(viewModel.$error,perform:{ error in
                if error != nil {
                    showAlert.toggle()
                }
            })
            .alert(isPresented: $showAlert,content: {
                Alert(
                    title: Text("Erorr"),
                    message: Text(viewModel.error?.localizedDescription ?? "" )
                )
            })
            Spacer()
            Divider()
            Button{
                dismiss()
            } label: {
                HStack(spacing: 3){
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.heavy)
                }
                .foregroundColor(.black)
                .font(.footnote)
            }
            .padding(.vertical,16)
        }
    }
}

struct RegisterationView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterationView()
    }
}
