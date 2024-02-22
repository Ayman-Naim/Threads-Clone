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
    @State private var signUpError = false
    @State private var signUpSucsess = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Spacer()
            Image("App-Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 120,height: 120)
            
            VStack{
                TextField("Enter Your Email", text: $viewModel.email,onCommit: {
                    if !viewModel.isEmailValid(){
                        viewModel.error = SignError.invalidEmail
                        signUpError = true
                        showAlert = true 
                        }

                })
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .modifier(ThreadsTextfiledModifires())
                    .submitLabel(.next)
              
                SecureField("Enter Your password", text: $viewModel.password,onCommit: {
                    if !viewModel.isPasswordValid(){
                        viewModel.error = SignError.invalidPassword
                        signUpError = true
                        showAlert = true
                        }

                })
                    .modifier(ThreadsTextfiledModifires())
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                TextField("Enter Your Full name", text: $viewModel.fullName,onCommit: {
                    if !viewModel.isFullNameValid(){
                        viewModel.error = SignError.invalidName
                        signUpError = true
                        showAlert = true
                        }

                })
                    .modifier(ThreadsTextfiledModifires())
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                TextField("Enter Your username", text: $viewModel.userName,onCommit: {
                    if !viewModel.isUserNameValid(){
                        viewModel.error = SignError.invalidUserName
                        signUpError = true
                        showAlert = true
                        }

                })
                    .modifier(ThreadsTextfiledModifires())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .submitLabel(.done)
                
            }

          
            Button{
               
                Task{ try await viewModel.CreateUser()
                   
                   
                }
                
                    
            }label: {
                Text("SignUp")
                    .modifier(ButtonsModifires())
                
            }
          
            .onReceive(viewModel.$error,perform:{ error in
                if error != nil {
                    signUpError.toggle()
                    showAlert.toggle()
                }
             
                        
            })
            .onReceive(viewModel.$userSignupSucsess, perform: { usersucsees in
                if usersucsees == true{
                    signUpSucsess.toggle()
                    showAlert.toggle()
                  
                }
            })
            
            .alert(isPresented: $showAlert,content: {
                if signUpError == true{
                   
                   return  Alert(
                        title: Text("Erorr"),
                        message: Text(viewModel.error?.localizedDescription ?? ""),
                        dismissButton:.default (Text("Cancel"),action:{
                            signUpError.toggle()
                        })
                    )
                   
                }
                if signUpSucsess == true {
                 return    Alert(
                       title: Text("Sign up User Sucsessfully"),
                       message: Text("user Created successfully you can sign in now "),
                       primaryButton: .default(Text("Cancel"),action: {
                          
                           //signUpSucsess.toggle()
                       }) ,
                       secondaryButton:.default(Text("LogIn"),action: {
                           //signUpSucsess.toggle()
                           dismiss()
                       })
                            
                           
                    )
                }
                
                return Alert(title:Text("NetworkError"))
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
struct ShakeEffect: GeometryEffect {
       func effectValue(size: CGSize) -> ProjectionTransform {
           return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
       }
       
       init(shakes: Int) {
           position = CGFloat(shakes)
       }
       
       var position: CGFloat
       var animatableData: CGFloat {
           get { position }
           set { position = newValue }
       }
   }
struct RegisterationView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterationView()
    }
}
