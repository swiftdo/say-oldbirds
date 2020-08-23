import Fluent
import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get { req -> EventLoopFuture<View> in
        struct Context: Encodable {
            let title: String
            let body: String
        }
        let context = Context(title: "Hi", body: "Hello world!")
        return req.view.render("index", context)
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    try app.register(collection: MessageController())
}
