//
//  File.swift
//  
//
//  Created by laijihua on 2020/9/1.
//

import Vapor

protocol Output: Content {}

struct OutputCode: Output {
    var code: Int
    var message: String

    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}

/// api 接口输出的格式
struct OutputJson<T: Output>: Output {
    var code: Int // 响应码
    var message: String // 响应信息
    let data: T? // 响应数据

    init(code: OutputCode, data: T?) {
        self.code = code.code
        self.message = code.message
        self.data = data
    }

    init(success data: T) {
        self.init(code: .ok, data: data)
    }

    init(error code: OutputCode) {
        self.init(code: code, data: nil)
    }
}

extension String: Output {

}

extension Array: Output where Element: Output {

}

/// 自定义返回码
extension OutputCode {
    static var ok = OutputCode(code: 0, message: "请求成功")
}
