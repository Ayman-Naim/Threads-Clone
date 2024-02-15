//
//  CreateThreadView.swift
//  ThreadsClone
//
//  Created by ayman on 09/09/2023.
//

import SwiftUI

struct CreateThreadView: View {
    @StateObject var viewModel = CreateThreadViewModel()
    @State private var caption = ""
    @State var edit =  false
    @Binding var thread : Thread

    
    init(thread : Binding<Thread>,edit:State<Bool>)
    {
        self._edit = edit
        self._thread = thread
    }
    private var user: User? {
        return UserService.shared.currentUser
    }
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack{
                HStack(alignment:.top){
                   
                    CircularProfileImageView(user: user,size: .small)
                    VStack(alignment:.leading,spacing:4){
                        Text(user?.userName ?? "" )
                            .fontWeight(.semibold)
                        if edit == true {
                          //  caption = thread?.caption ?? "update the thread "
                            TextField(thread.caption ?? "update the thread ", text:
                                        $caption,axis:.vertical)
                        }else{
                            TextField("Start a Thread...", text:
                                        $caption,axis:.vertical)
                        }
                        
                    }
                    .font(.footnote)
                    Spacer()
                    
                    if !caption.isEmpty{
                        Button {
                            caption=""
                        }label:{
                            Image(systemName:"xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        }
                    }
                  
                }
               Spacer()
            
            }.padding()
            
                .navigationBarTitle(edit == false ? "NewThread":"Update Thread")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement:.navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                    
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                ToolbarItem(placement:.navigationBarTrailing){
                    Button(edit == false ? "Post":"Update"){
                        if edit == false {
                            Task{try await viewModel.uploadThread(caption: caption)
                                dismiss()
                            }
                            
                        }
                        else{
                            Task{try await viewModel.UpdateThread(caption: caption,thread:thread)
                                thread.caption = caption
                                dismiss()
                            }
                        }
                    }
                    .opacity(caption.isEmpty ? 0.5:1)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
                
            }
            
            }
        }
    }


struct CreateThreadView_Previews: PreviewProvider {
    static var previews: some View {
        CreateThreadView(thread: .constant(dev.thread), edit: .init(initialValue: false))
    }
}
