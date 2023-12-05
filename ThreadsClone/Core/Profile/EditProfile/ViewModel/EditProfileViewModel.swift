//
//  EditProfileViewModel.swift
//  ThreadsClone
//
//  Created by ayman on 05/12/2023.
//

import Foundation
import PhotosUI
import SwiftUI

class EditProfileViewModel : ObservableObject {
    @Published var selectedItem:PhotosPickerItem?{
        didSet { Task{ await LoadImage() } }
    }
    @Published var profileImage : Image?
    private var uiImage : UIImage?
    func updateUserData()async  throws{
        print("Debug update user data ")
        try await  updateProfileImage()
        
    }
    
   @MainActor
    private func LoadImage()async{
        guard let item  = selectedItem else {return }
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else{return }
        self.uiImage = uiImage
        self.profileImage =  Image(uiImage: uiImage)
    }
    
    private func updateProfileImage () async throws {
        guard let image = self.uiImage else {return }
        guard let imageUrl = try? await ImageUploader.uploadImage(image) else {return}
        try await  UserService.shared.updateUserProfileImge(withImageUrl: imageUrl)
        
    }
    
}
