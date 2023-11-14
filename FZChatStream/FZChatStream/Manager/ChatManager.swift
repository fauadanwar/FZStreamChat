//
//  ChatManager.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

import Foundation
import StreamChat
import StreamChatSwiftUI
import SwiftUI


final class AppCoordinator: ObservableObject {
    @Published var screen: Screen = .login
}

final class ChatManager {
    
    private var streamChat: StreamChat?
    static let shared = ChatManager()
    private var chatClient: ChatClient!
    private let tokens = ["fahman": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZmFobWFuIn0.DmuHZ4JiT_vUsgeby2b_f2fTvn6RFsMh0_Szrok69wg",
                          "zohan": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiem9oYW4ifQ.QZvGbMGMoLQ0snYZ-xurwPIGO2ZRSg8q35JYwFOFl7c"]
    init() {
        self.coordinator = AppCoordinator()
    }
    var coordinator: AppCoordinator!
    var channelListController: ChatChannelListController?
    
    var isSignedIn: Bool {
        chatClient.currentUserId != nil
    }
    
    var curruntUser: String? {
        chatClient.currentUserId
    }
    
    func setup() {
        self.chatClient = ChatClient(config: .init(apiKeyString: "28rzt3ne79nn"))
        // The `StreamChat` instance we need to assign
        streamChat = StreamChat(chatClient: chatClient)
        self.coordinator.screen = isSignedIn ? .home : .login
        
    }
    
    func signIn(name: String, completion: @escaping (String?) -> Void) {
        
        guard let token = tokens[name] else
        {
            completion("User name not present")
            return
        }
        chatClient.connectUser(userInfo: UserInfo(id: name, name: name), token: Token(stringLiteral: token)) { error in
            guard let error else {
                DispatchQueue.main.async {
                    self.coordinator.screen = .home
                    completion(nil)
                }
                return
            }
            // Some very basic error handling only logging the error.
            completion("connecting the user failed \(error)")
        }
    }
    
    func signOut(completion: @escaping () -> Void) {
        chatClient.disconnect {
            
        }
        chatClient.logout {
            
        }
        DispatchQueue.main.async {
            self.coordinator.screen = .login
            completion()
        }
    }
    
    public func createChannelList() -> ChannelListView {
        ChannelListView()
    }
    
    public func getChatChannelListController() -> ChatChannelListController? {
        guard let id = curruntUser else { return nil }
        let query = ChannelListQuery(filter: .containMembers(userIds: [id]))
        channelListController = chatClient.channelListController(query: query)
        return channelListController
    }
    
    public func createNewChannel(name: String) {
        guard let currunt = curruntUser else { return }
        let keys = tokens.keys.filter { $0 != currunt }.map { $0 }
        do {
            let result = try chatClient.channelController(createChannelWithId: .init(type: .messaging, id: name), name: name, members: Set(keys), isCurrentUserMember: true)
            result.synchronize()
        } catch {
            print("\(error )")
        }
    }
    
}

