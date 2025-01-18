import ExampleApp
import XCTVaporExtensions
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
}
