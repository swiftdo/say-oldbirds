import Fluent
import Vapor

final class Message: Model, Content {
    static let schema = "messages"

    struct FieldKeys {
        static var name: FieldKey { "name" }
        static var body: FieldKey { "body" }
        static var cratedAt: FieldKey { "created_at" }
    }

    @ID(key: .id) var id: Int?
    @Field(key: FieldKeys.name) var name: String
    @Field(key: FieldKeys.body) var body: String

    // https://docs.vapor.codes/4.0/fluent/model/#timestamp
    @Timestamp(key: FieldKeys.cratedAt, on: .create) var createdAt: Date?

    init() { }

    init(id: Int? = nil, name: String, body: String) {
        self.id = id
        self.name = name
        self.body = body
    }
}
