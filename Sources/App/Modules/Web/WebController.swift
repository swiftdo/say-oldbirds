import Fluent
import Vapor
import Leaf

struct WebController {
    func index(req: Request) throws -> EventLoopFuture<View> {
        struct Context: Encodable {
            let messages: [Message.ViewContext]
            let count: Int
        }
        return Message
            .query(on: req.db)
            .sort(\.$createdAt, .descending)
            .all()
            .flatMapThrowing {
                return try $0.map{ try Message.ViewContext(message: $0)}
            }
            .flatMap {
                let context = Context(messages: $0, count: $0.count)
                return req.view.render("index", context)
            }
    }

    func create(req: Request) throws ->  EventLoopFuture<Response>{
        let message = try req.content.decode(Message.self)
        req.logger.log(level: .info, "\(message)")
        return message.save(on: req.db).map {
            return req.redirect(to: "/")
        }
    }
}
