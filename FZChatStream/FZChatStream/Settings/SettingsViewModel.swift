//
//  SettingsViewModel.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

import Foundation

// Home ViewModel Protocol
protocol SettingsViewModelProtocol {
    var settingsModel: SettingsModel { get }
    var homeViewModel: HomeViewModelProtocol? { get }
    func logout()
}

// Home ViewModel
class SettingsViewModel: SettingsViewModelProtocol {
    var homeViewModel: HomeViewModelProtocol?
    var settingsModel: SettingsModel
    
    init(settingsModel: SettingsModel, homeViewModel: HomeViewModelProtocol?) {
        self.settingsModel = settingsModel
        self.homeViewModel = homeViewModel
    }
    
    func logout() {
        // Add any logout logic here
        ChatManager.shared.signOut {
            
        }
    }
}
