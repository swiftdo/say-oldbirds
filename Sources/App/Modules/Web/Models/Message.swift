import Fluent
import Vapor

final class Message: Model, Content {
    static let schema = "messages"

    @ID(custom: FieldKeys.id) var id: Int?
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

extension Message {
    struct FieldKeys {
        static var name: FieldKey { "name" }
        static var body: FieldKey { "body" }
        static var cratedAt: FieldKey { "created_at" }
        static var id: FieldKey {"id"}
    }

    struct ViewContext: Codable {
        var id: Int
        var name: String
        var message: String
        var time: String

        init(message: Message) throws {
            self.id = try message.requireID()
            self.name = message.name
            self.message = message.body
            self.time = message.createdAt!.so_str
        }
    }
}

extension Date {
    var so_str: String {
        let interval: Int = Int(Date().timeIntervalSince(self))
        let calendar = Calendar.current
        let formatter = DateFormatter()

        if calendar.isDateInToday(self) {
            if interval < 60 {
                return "刚刚";
            } else if interval < 60 * 60 {
                return "\(interval/60)分钟前";
            } else if interval < 60 * 60 * 24 {
                return "\(interval/(60 * 60))小时前";
            } else {
                return "今天";
            }
        } else if calendar.isDateInYesterday(self) {
            formatter.dateFormat = "昨天 HH:mm"
            return formatter.string(from: self)
        } else {
            let comps = calendar.dateComponents([Calendar.Component.year], from: self, to: Date())
            if let year = comps.year, year >= 1 {
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
            } else {
                formatter.dateFormat = "MM-dd HH:mm"
            }
            return formatter.string(from: self)
        }
    }
}
