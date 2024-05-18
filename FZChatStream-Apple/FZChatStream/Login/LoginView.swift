//
//  LoginView.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var loginModel: LoginModel
    @State private var username: String = ""
    var viewModel: LoginViewModelProtocol

    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        self.loginModel = viewModel.loginModel
    }

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Username", text: $username)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                            .shadow(color: .gray, radius: 3, x: 1, y: 1)
                    )
                    .padding(.horizontal)
                    .autocapitalization(.none)

                if let errorText = loginModel.errorText {
                    Text(errorText)
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }

                Button(action: {
                    viewModel.login(username: username)
                }) {
                    Text("Login")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                Spacer()
            }
            .padding()
            .navigationBarTitle("FZ Chat", displayMode: .inline)
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
