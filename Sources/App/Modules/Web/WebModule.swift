//
//  File.swift
//  
//
//  Created by laijihua on 2020/9/1.
//

import Vapor
import Fluent

struct WebModule: Module {
    var router: RouteCollection? {
        WebRouter()
    }

    var migrations: [Migration] {
        [CreateMessage()]
    }

}
