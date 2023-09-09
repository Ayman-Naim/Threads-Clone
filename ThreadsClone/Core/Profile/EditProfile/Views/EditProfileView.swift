//
//  EditProfileView.swift
//  ThreadsClone
//
//  Created by ayman on 10/09/2023.
//

import SwiftUI

struct EditProfileView: View {
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivateProfile = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom  ,.horizontal])
                VStack{
                    //for name and image
                    HStack{
                        VStack(alignment:.leading){
                            Text("Name")
                                .fontWeight(.semibold)
                            
                            Text("Ayman Naim")
                             
                        }
                        Spacer()
                        CircularProfileImageView()
                    }
                    Divider()
                    
                    //bio
                    VStack(alignment:.leading){
                        Text("Bio")
                            .fontWeight(.semibold)
                        
                        TextField("Enter your bio...", text: $bio,axis:.vertical)
                    }
                    
                    
                    Divider()
                    VStack(alignment:.leading){
                        Text("Link")
                            .fontWeight(.semibold)
                        
                        TextField("Add link..", text: $link)
                    }
                    
                    Divider()
                    HStack{
                    
                        Toggle("Private Profile", isOn: $isPrivateProfile)
                    }
                }
                .font(.footnote)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4
                                      ),lineWidth:1)
                }
                .padding()
                
            }
            .navigationBarTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement:.navigationBarLeading){
                    Button("Cancel"){
                        
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                ToolbarItem(placement:.navigationBarTrailing){
                    Button("Done"){
                        
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
            }
           
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
