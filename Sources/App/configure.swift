import Fluent
import FluentPostgresDriver
import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) throws {
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    let error = ErrorMiddleware.default(environment: app.environment)
    let file = FileMiddleware(publicDirectory: app.directory.publicDirectory)

    app.middleware.use(cors)
    app.middleware.use(error)
    app.middleware.use(file)

    /// 配置 Leaf
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease



    /// MacOS:
    /// brew install postgresql
    /// brew link postgresql
    /// brew services start postgresql
    /// brew services stop postgresql
    /// MacOS 创建一个 PostgresSQL 用户：createuser root -P
    /// MacOS 创建数据库:  createdb say-oldbirds -O root -E UTF8 -e

    if let databaseURL = Environment.get("DATABASE_URL") {
        app.databases.use(try .postgres(
            url: databaseURL
        ), as: .psql)
    } else {
        app.databases.use(.postgres(
            hostname: Environment.get("DATABASE_HOST") ?? "localhost",
            username: Environment.get("DATABASE_USERNAME") ?? "root",
            password: Environment.get("DATABASE_PASSWORD") ?? "", // macos 无需设置密码
            database: Environment.get("DATABASE_NAME") ?? "say-oldbirds"
        ), as: .psql)
    }

    let modules: [Module] = [
        WebModule(),
        ApiModule(),
    ]

    for module in modules {
        try module.configure(app)
    }
}
