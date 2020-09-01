//
//  File.swift
//  
//
//  Created by laijihua on 2020/9/1.
//

import Vapor

struct ApiController {
    
    func index(_ req: Request) throws -> EventLoopFuture<OutputJson<OuputMessages>> {
        return Message
            .query(on: req.db)
            .sort(\.$createdAt, .descending)
            .all()
            .flatMapThrowing {try OuputMessages.init(messages: $0, count: $0.count)}
            .map{
                OutputJson(success: $0)
            }
    }

    func create(_ req: Request) throws -> EventLoopFuture<OutputJson<Message.ViewContext>> {
        let message = try req.content.decode(Message.self)
        req.logger.log(level: .info, "\(message)")
        return message.save(on: req.db).flatMapThrowing {
            OutputJson(success: try Message.ViewContext(message: message))
        }
    }

}
