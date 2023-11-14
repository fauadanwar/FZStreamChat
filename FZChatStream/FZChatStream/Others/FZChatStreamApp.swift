//
//  FZChatStreamApp.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

import StreamChat
import StreamChatSwiftUI
import UIKit
import SwiftUI

@main
struct FZChatStreamApp: App {
    
    // This is the `StreamChat` reference we need to add
    var streamChat: StreamChat?
    
    // This is the `chatClient`, with config we need to add
    var chatClient: ChatClient = {
        //For the tutorial we use a hard coded api key and application group identifier
        var config = ChatClientConfig(apiKey: .init("28rzt3ne79nn"))
//        config.applicationGroupIdentifier = "com.fz.FZStreamChat.iOS.FZStreamChatApp"
        
        // The resulting config is passed into a new `ChatClient` instance.
        let client = ChatClient(config: config)
        return client
    }()
    
    init() {
        setUpChannel()
    }
    
    var body: some Scene {
        WindowGroup {
            ChatChannelListView(viewFactory: CustomViewFactory())
        }
    }
    
    mutating func setUpChannel()
    {
        var colors = ColorPalette()
        let streamBlue = UIColor(red: 0, green: 108.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        colors.tintColor = Color(streamBlue)

        var fonts = Fonts()
        fonts.footnoteBold = Font.footnote
        fonts.body = Font.title

        let images = Images()
        images.reactionLoveBig = UIImage(systemName: "heart.fill")!

        let appearance = Appearance(colors: colors, images: images, fonts: fonts)

        let channelNamer: ChatChannelNamer = { channel, currentUserId in
            "This is our custom name: \(channel.name ?? "no name")"
        }

        let customResolver = CustomMessageResolver()
        let utils = Utils(messageTypeResolver: customResolver, channelNamer: channelNamer)
        
        // The `StreamChat` instance we need to assign
        streamChat = StreamChat(chatClient: chatClient, appearance: appearance, utils: utils)
        
        // Calling the `connectUser` functions
        connectUser()
    }
    
    // The `connectUser` function we need to add.
    private func connectUser() {
        // This is a hardcoded token valid on Stream's tutorial environment.
        let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZm91YWRfYW53YXIifQ.VvkgpgsIooFtSCVAQDr94mTzcmkikEsvyBLRq0p846E")
        
        // Call `connectUser` on our SDK to get started.
        chatClient.connectUser(
            userInfo: .init(id: "fouad_anwar",
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
}
