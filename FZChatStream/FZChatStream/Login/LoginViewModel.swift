//
//  LoginViewModel.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

import Foundation

// Login ViewModel Protocol
protocol LoginViewModelProtocol {
    var loginModel: LoginModel { get }
    func login(username: String)
}

// Login ViewModel
class LoginViewModel: LoginViewModelProtocol {
    var loginModel: LoginModel

    init(loginModel: LoginModel = LoginModel()) {
        self.loginModel = loginModel
    }

    func login(username: String) {
        if username.isEmpty {
            self.loginModel.errorText = "Username cannot be empty"
        } else {
            self.loginModel.errorText = nil
            ChatManager.shared.signIn(name: username, completion: { [weak self] errorText in
                DispatchQueue.main.async {
                    if let errorText {
                        self?.loginModel.errorText = errorText
                    }
                }
            })
        }
    }
}
