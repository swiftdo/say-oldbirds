//
//  File.swift
//  
//
//  Created by laijihua on 2020/9/1.
//

import Vapor

struct WebRouter: RouteCollection {
    let controller = WebController()

    func boot(routes: RoutesBuilder) throws {
        routes.get(use: self.controller.index)
        routes.post("create", use: self.controller.create)
    }
}

