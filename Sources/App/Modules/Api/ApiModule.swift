//
//  File.swift
//  
//
//  Created by laijihua on 2020/9/1.
//

import Vapor
import Fluent

struct ApiModule: Module {
    var router: RouteCollection? {
        ApiRouter()
    }
}
