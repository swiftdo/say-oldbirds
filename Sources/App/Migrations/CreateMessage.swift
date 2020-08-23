import Fluent

struct CreateMessage: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Message.schema)
            .field(.id, .int, .identifier(auto: true))
            .field(Message.FieldKeys.name, .string, .required)
            .field(Message.FieldKeys.body, .string, .required)
            .field(Message.FieldKeys.cratedAt, .datetime)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Message.schema).delete()
    }
}
