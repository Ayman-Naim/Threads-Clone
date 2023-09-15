//
//  ContentView.swift
//  ThreadsClone
//
//  Created by ayman on 08/09/2023.
//
import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModell()
    
    var body: some View {
        Group {
            if viewModel.userSession == nil{
               // let _ = print(viewModel.userSession)
                LoginView()
            }
            else {
               // let _ = print(viewModel.userSession)
                ThreadsTabView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

