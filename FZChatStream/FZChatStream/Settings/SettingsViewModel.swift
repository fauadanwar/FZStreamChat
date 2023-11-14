//
//  SettingViewModel.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

import Foundation

// Home ViewModel Protocol
protocol SettingViewModelProtocol {
    var settingModel: SettingModel { get }
    var homeViewModel: HomeViewModelProtocol? { get }
    func logout()
}

// Home ViewModel
class SettingViewModel: SettingViewModelProtocol {
    var homeViewModel: HomeViewModelProtocol?
    var settingModel: SettingModel
    
    init(settingModel: SettingModel = SettingModel()) {
        self.settingModel = settingModel
    }
    
    func logout() {
        // Add any logout logic here
        ChatManager.shared.signOut { [weak self] in
            DispatchQueue.main.async {
                self?.homeViewModel?.logout()
            }
        }
    }
}
