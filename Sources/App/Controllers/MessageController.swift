import Fluent
import Vapor
import Leaf

struct MessageController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: index)
        routes.post(use: create)
    }

    func index(req: Request) throws -> EventLoopFuture<View> {
        struct Context: Encodable {
            let messages: [Message.ViewContext]
        }
        return Message
            .query(on: req.db)
            .sort(\.$createdAt, .descending)
            .all()
            .flatMapThrowing {
                return try $0.map{ try Message.ViewContext(message: $0) }
            }
            .flatMap {

                let context = Context(messages: $0)
                return req.view.render("index", context)
            }
    }

    func create(req: Request) throws -> EventLoopFuture<Message> {
        let message = try req.content.decode(Message.self)
        return message.save(on: req.db).map { message }
    }
}
