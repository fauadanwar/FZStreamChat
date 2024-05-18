//
//  ChatListView.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct ChatListView: View {
    @State private var isCreateAlertPresented = false
    @State private var newChannelName: String = ""
    
    var chatListViewModel: ChatListViewModelprotocol
    
    var body: some View {
        NavigationView {
            ChatChannelListView(channelListController: chatListViewModel.getChatChannelListView())
                .navigationBarTitle("Chats", displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                    isCreateAlertPresented = true
                }) {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }
                )
                .alert("Create Channel", isPresented: $isCreateAlertPresented) {
                    TextField("Channel Name", text: $newChannelName)
                    Button("Create", action: createChannel)
                    Button("Cancel", role: .cancel){}
                } message: {
                    Text("Enter the name for the new Channel")
                }
        }
    }
    
    func createChannel() {
        chatListViewModel.createNewChannel(name: newChannelName)
    }
}

#Preview {
    ChatListView(chatListViewModel: ChatListViewModel())
}
