//
//  File.swift
//  
//
//  Created by laijihua on 2020/9/1.
//

import Foundation

struct OuputMessages: Output {
    let messages: [Message.ViewContext]
    let count: Int

    init(messages: [Message], count: Int) throws {
        self.messages = try messages.map { try Message.ViewContext(message: $0) }
        self.count = count
    }
}

extension Message.ViewContext: Output {}

