//
//  File.swift
//  
//
//  Created by laijihua on 2020/9/1.
//

import Fluent

struct WebMigration_v1_0_0: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Message.schema)
            .field(Message.FieldKeys.id, .int, .identifier(auto: true))
            .field(Message.FieldKeys.name, .string, .required)
            .field(Message.FieldKeys.body, .string, .required)
            .field(Message.FieldKeys.cratedAt, .datetime)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Message.schema).delete()
    }
}
