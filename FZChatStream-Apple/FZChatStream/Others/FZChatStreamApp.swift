//
//  FZChatStreamApp.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

import SwiftUI

// Specify all root level screens
enum Screen {
    case login
    case home
}

@main
struct FZChatStreamApp: App {
    
    @ObservedObject var coordinator: AppCoordinator

    init() {
        ChatManager.shared.setup()
        self.coordinator = ChatManager.shared.coordinator
    }
    
    var body: some Scene {
        WindowGroup {
            switch coordinator.screen {
            case .login:
                LoginView(viewModel: LoginViewModel())
            case .home:
                HomeView(homeViewModel: HomeViewModel())
            }
        }
    }
}
