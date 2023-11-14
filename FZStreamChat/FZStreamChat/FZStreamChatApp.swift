//
//  FZStreamChatApp.swift
//  FZStreamChat
//
//  Created by fanwar on 11/11/23.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

@main
struct FZStreamChatApp: App {
    
    // This is the `StreamChat` reference we need to add
    var streamChat: StreamChat?

    // This is the `chatClient`, with config we need to add
    var chatClient: ChatClient = {
        //For the tutorial we use a hard coded api key and application group identifier
        var config = ChatClientConfig(apiKey: .init("28rzt3ne79nn"))
        config.applicationGroupIdentifier = "com.fz.FZStreamChat.iOS.FZStreamChatApp"

        // The resulting config is passed into a new `ChatClient` instance.
        let client = ChatClient(config: config)
        return client
    }()
    
    init() {
        // The `StreamChat` instance we need to assign
        streamChat = StreamChat(chatClient: chatClient)
        
        // Calling the `connectUser` functions
        connectUser()
    }
    
    // The `connectUser` function we need to add.
    private func connectUser() {
        // This is a hardcoded token valid on Stream's tutorial environment.
        let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZm91YWQuYW53YXIifQ.yPcnGHSbeGvyEC04pGV0AuKn_9BivuoHGz--n6XdkPc")

        // Call `connectUser` on our SDK to get started.
        chatClient.connectUser(
                userInfo: .init(id: "fouad.anwar",
                                name: "Fouad Anwar",
                                imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!),
                token: token
        ) { error in
            if let error = error {
                // Some very basic error handling only logging the error.
                log.error("connecting the user failed \(error)")
                return
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            ChatChannelListView()
//            ContentView()
        }
    }
}
