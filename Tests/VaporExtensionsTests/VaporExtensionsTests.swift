import ExampleApp
import VaporTestUtils
import VaporExtensions

final class VaporExtensionsTests: VaporTestCase {

    override var configurer: AppConfigurer{
        return ExampleApp.configure
    }

    func testMyApp() throws {
        try test(.GET, "testing-vapor-apps") { response in
            XCTAssertEqual(response.status, .ok)
            XCTAssert(response.has(content: "is super easy"))
        }

        let response = try awaitTest(.GET, "testing-vapor-apps")
        XCTAssertEqual(response.status, .ok)
        XCTAssert(response.has(content: "is super easy"))
    }

    func testFailedUnwrap() throws {
        let failed = failedFuture(on: app)
        let error = Abort(.badRequest)
        let request = failed.unwrap(or: error).map { value in
            XCTFail()
        }
        XCTAssertThrowsError(try request.wait())

        let mapRequest = failed.mapUnwrapped(or: error, completion: { value in
            XCTFail()
        })

        XCTAssertThrowsError(try mapRequest.wait())

        let flatMapRequest = failed.flatMapUnwrapped(or: error) { value in
            return self.app.toFuture(XCTFail())
        }

        XCTAssertThrowsError(try flatMapRequest.wait())
    }

    func testSuccessfulUnwrap() throws {
        let successValue = "success"
        let editValue = "edit"
        let successEditedValue = "\(successValue)+\(editValue)"
        let success = successFuture(on: app, value: successValue)
        let error = Abort(.badRequest)
        let request = success.unwrap(or: error).map { value in
            "\(value)+\(editValue)"
        }
        XCTAssert(try request.wait() == successEditedValue)

        let mapRequest = success.mapUnwrapped(or: error, completion: { value in
            return "\(value)+\(editValue)"
        })

        XCTAssert(try mapRequest.wait() == successEditedValue)


        let flatMapRequest = success.flatMapUnwrapped(or: error) { value in
            return self.app.toFuture("\(value)+\(editValue)")
        }

        XCTAssert(try flatMapRequest.wait() == successEditedValue)
    }

    func testFlatMapOrFail() throws {
        let failed = failedFuture(on: app)
        let request = failed.unwrap(or: Abort(.badRequest)).map { value in
            XCTFail()
        }
        XCTAssertThrowsError(try request.wait())
    }

    func failedFuture(on eventLoop: EventLoopReferencing) -> Future<String?> {
        return eventLoop.toFuture(nil)
    }

    func successFuture(on eventLoop: EventLoopReferencing, value: String) -> Future<String?> {
        return eventLoop.toFuture(value)
    }
}
