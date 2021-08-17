//
//  VaporTestCase.swift
//  VaporTestUtils
//
//  Created by Brian Strobach on 12/6/17.
//

import XCTest
import XCTVapor

public typealias AppConfigurer = (_ app: Application) throws -> Void

open class VaporTestCase: XCTestCase {

    open lazy var loggingLevel: LoggingLevel = .none
    
    open var app: Application!

    open var configurer: AppConfigurer{
        return { _ in }
    }

    override open func setUpWithError() throws {
        try super.setUpWithError()
        app = try createApplication()
        try addConfiguration(to: app)
    }

    override open func tearDown() {
        super.tearDown()
        app.shutdown()
    }

    open func createApplication() throws -> Application {
        let app = Application(.testing)
        try configurer(app)
        return app
    }

    open func addConfiguration(to app: Application) throws {
        try addRoutes(to: app.routes)
    }

    open func addRoutes(to router: Routes) throws {}

}

public enum LoggingLevel{
    case none, requests, responses, debug
}
extension VaporTestCase{
	open func log(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line){
		guard loggingLevel != .none else { return }
		let fileName = file.split(separator: "/").last!
		print("\n⏱ \(Date()) 👉 \(fileName).\(function) line \(line) 👇\n\n\(String(describing: message()))\n\n")
	}

	open func log(response: Response){
		switch loggingLevel {
		case .debug, .responses:
            log("RESPONSE:\n\(response)")
		default:
			return
		}
	}
}
