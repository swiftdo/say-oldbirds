//
//  File.swift
//  
//
//  Created by laijihua on 2020/9/1.
//

import Vapor

struct ApiRouter: RouteCollection {
    let controller = ApiController()

    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        api.get(use: self.controller.index)
        api.post("create", use: self.controller.create)
    }
}
