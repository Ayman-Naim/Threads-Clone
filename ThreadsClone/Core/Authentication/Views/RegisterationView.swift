//
//  RegisterationView.swift
//  ThreadsClone
//
//  Created by ayman on 08/09/2023.
//

import SwiftUI

struct RegisterationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var userName = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Spacer()
            Image("App-Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 120,height: 120)
            
            VStack{
                TextField("Enter Your Email", text: $email)
                    .autocapitalization(.none)
                    .modifier(ThreadsTextfiledModifires())
                
                SecureField("Enter Your password", text: $password)
                    .modifier(ThreadsTextfiledModifires())
                
                TextField("Enter Your Full name", text: $fullName)
                    .modifier(ThreadsTextfiledModifires())
                
                TextField("Enter Your username", text: $userName)
                    .modifier(ThreadsTextfiledModifires())
                
                
            }
            Button{
                
            }label: {
                Text("Login")
                    .modifier(ButtonsModifires())
                
            }
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
