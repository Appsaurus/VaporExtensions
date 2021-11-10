//
//  Logger+StringMessage.swift
//
//
//  Created by Brian Strobach on 9/1/21.
//

public extension Logger {

    func log(level: Logger.Level,
             _ string: @autoclosure () -> String,
             metadata: @autoclosure () -> Logger.Metadata? = nil,
             file: String = #file, function: String = #function, line: UInt = #line) {
        let message = Logger.Message(stringLiteral: string())
        self.log(level: level, message, metadata: metadata(), file: file, function: function, line: line)
    }

    func trace(_ string: @autoclosure () -> String,
             metadata: @autoclosure () -> Logger.Metadata? = nil,
             file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .trace, string(), metadata: metadata(), file: file, function: function, line: line)
    }


    func debug(_ string: @autoclosure () -> String,
             metadata: @autoclosure () -> Logger.Metadata? = nil,
             file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .debug, string(), metadata: metadata(), file: file, function: function, line: line)
    }

    func info(_ string: @autoclosure () -> String,
             metadata: @autoclosure () -> Logger.Metadata? = nil,
             file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .info, string(), metadata: metadata(), file: file, function: function, line: line)
    }

    func notice(_ string: @autoclosure () -> String,
             metadata: @autoclosure () -> Logger.Metadata? = nil,
             file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .notice, string(), metadata: metadata(), file: file, function: function, line: line)
    }

    func warning(_ string: @autoclosure () -> String,
             metadata: @autoclosure () -> Logger.Metadata? = nil,
             file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .warning, string(), metadata: metadata(), file: file, function: function, line: line)
    }

    func error(_ string: @autoclosure () -> String,
             metadata: @autoclosure () -> Logger.Metadata? = nil,
             file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .error, string(), metadata: metadata(), file: file, function: function, line: line)
    }

    func critical(_ string: @autoclosure () -> String,
             metadata: @autoclosure () -> Logger.Metadata? = nil,
             file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .critical, string(), metadata: metadata(), file: file, function: function, line: line)
    }
}
