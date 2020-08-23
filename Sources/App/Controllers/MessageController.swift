import Fluent
import Vapor

struct MessageController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("message")
        todos.get(use: index)
        todos.post(use: create)
    }

    func index(req: Request) throws -> EventLoopFuture<[Message]> {
        return Message.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Message> {
        let message = try req.content.decode(Message.self)
        return message.save(on: req.db).map { message }
    }
}
