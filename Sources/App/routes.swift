import Fluent
import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    try app.register(collection: MessageController())
}
