//
//  ThreadsTextFieldsModifires .swift
//  ThreadsClone
//
//  Created by ayman on 08/09/2023.
//

import SwiftUI
struct ThreadsTextfiledModifires:ViewModifier{
    func body(content: Content) -> some View {
        content
        .font(.subheadline)
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal,26)
    }
    
}
