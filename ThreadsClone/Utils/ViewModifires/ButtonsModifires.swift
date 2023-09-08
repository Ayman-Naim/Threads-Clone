//
//  ButtonsModifires.swift
//  ThreadsClone
//
//  Created by ayman on 08/09/2023.
//

import SwiftUI
struct ButtonsModifires:ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold )
            .foregroundColor(.white)
            .frame(width: 352,height: 44)
            .background(.black)
            .cornerRadius(10)
    }
    
}
