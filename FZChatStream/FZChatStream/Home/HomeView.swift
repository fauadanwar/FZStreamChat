//
//  HomeView.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

import SwiftUI

// Home View
struct HomeView: View {
    var homeViewModel: HomeViewModelProtocol

    var body: some View {
        TabView {
            ChatListView(chatListViewModel: homeViewModel.getChatListViewModel())
                .tabItem {
                    Label("Menu", systemImage: "message")
                }
            SettingsView(settingsViewModel: homeViewModel.getSettingsViewModel())
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
} 

#Preview {
    HomeView(homeViewModel: HomeViewModel())
}
