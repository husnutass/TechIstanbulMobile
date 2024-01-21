//
//  NewUserView.swift
//  UserList
//
//  Created by Hüsnü Taş on 21.01.2024.
//

import SwiftUI

struct NewUserView: View {
    @Binding var isPresented: Bool
    @StateObject private var viewModel = NewUserViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Name", text: $viewModel.user.name)
                    TextField("Avatar URL", text: $viewModel.user.avatarUrl)
                    
                    Section("Bio") {
                        TextEditor(text: $viewModel.user.bio)
                    }
                }
                .navigationTitle("Add New User")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
                
                Button {
                    Task {
                        await viewModel.addUser()
                        isPresented.toggle()
                    }
                } label: {
                    Text("Add User")
                }
                
            }
        }
    }
}

#Preview {
    NewUserView(isPresented: .constant(true))
}
