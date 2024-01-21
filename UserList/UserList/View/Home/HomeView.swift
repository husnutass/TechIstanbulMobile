//
//  HomeView.swift
//  UserList
//
//  Created by Hüsnü Taş on 21.01.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var isPresented = false
    @State private var searchKey = ""
    
    private var filteredUsers: [User] {
        if searchKey.isEmpty {
            return viewModel.users
        }
        return viewModel.users.filter { $0.name.lowercased().contains(searchKey.lowercased()) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredUsers) { user in
                    NavigationLink {
                        DetailView(id: user.id)
                    } label: {
                        Text("\(user.name)")
                    }
                }
            }
            .refreshable {
                await viewModel.getUsers()
            }
            .searchable(text: $searchKey)
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    Image(systemName: "person.badge.plus")
                })
            }
            .sheet(isPresented: $isPresented, content: {
                NewUserView(isPresented: $isPresented)
            })
            .task {
                await viewModel.getUsers()
            }
        }
    }
}

#Preview {
    HomeView()
}
