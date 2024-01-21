//
//  DetailView.swift
//  UserList
//
//  Created by Hüsnü Taş on 21.01.2024.
//

import SwiftUI

struct DetailView: View {
    let id: String
    @StateObject private var viewModel = DetailViewModel()
    @State private var isChecked = false
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: viewModel.user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                }
                .frame(width: 100, height: 100)
                
                Text(viewModel.user?.name ?? "Name")
                    .font(.title.bold())
                
                Spacer()
            }
            .background(Color.blue)
            
            Text(viewModel.user?.bio ?? "Bio")
            
            
            Toggle("Is Checked", isOn: $isChecked)
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.getUser(with: id)
            if let user = viewModel.user {
                isChecked = user.isChecked
            }
        }
        .onChange(of: isChecked) { oldValue, newValue in
            Task {
                viewModel.user?.isChecked = newValue
                await viewModel.updateUser()
            }
        }
    }
}

#Preview {
    DetailView(id: "A3HRWs09YIcqQqQByI0J")
        .preferredColorScheme(.dark)
}
