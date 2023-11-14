//
//  HomeViewModel.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

// Home ViewModel Protocol
protocol HomeViewModelProtocol {
    func getChatListViewModel() -> ChatListViewModel
    func getSettingsViewModel() -> SettingsViewModel
}

// Home ViewModel
class HomeViewModel: HomeViewModelProtocol {
    
    func getChatListViewModel() -> ChatListViewModel
    {
        return ChatListViewModel()
    }
    
    func getSettingsViewModel() -> SettingsViewModel
    {
        return SettingsViewModel(settingsModel: SettingsModel(name: ChatManager.shared.curruntUser ?? "Unknown", imageName: nil), homeViewModel: self)
    }
}
