//
//  ChatListViewModel.swift
//  FZChatStream
//
//  Created by fanwar on 12/11/23.
//

import Foundation
import StreamChat
import StreamChatSwiftUI

protocol ChatListViewModelprotocol
{
    func getChatChannelListView() -> ChatChannelListController?
    func createNewChannel(name: String)
}

class ChatListViewModel: ChatListViewModelprotocol {
    
    func getChatChannelListView() -> ChatChannelListController? {
        if let channelListController = ChatManager.shared.getChatChannelListController()
        {
            channelListController.synchronize()
            return channelListController
        }
        return nil
    }
    
    func createNewChannel(name: String) {
        guard !name.isEmpty else {
            return
        }
        DispatchQueue.main.async {
            ChatManager.shared.createNewChannel(name: name)
        }
    }
}
