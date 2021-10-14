//
//  RoutesBuilderTests.swift
//
//
//  Created by Brian Strobach on 9/7/21.
//

import XCTest
import XCTVapor
import VaporExtensions
import VaporTestUtils
import CoreFoundation

class RouteParameterTests: VaporTestCase {
    let basePath = "path"
    override func addRoutes(to router: Routes) throws {
        try super.addRoutes(to: router)
        router.get(basePath, Int.pathComponent, use: respond)
        for route in app.routes.all {
            debugPrint(route.path.string)
        }

    }

    func respond(to request: Request, withInt int: Int) -> Future<Int> {
        return request.toFuture(int)
    }

    
    func testModelParameterRoute() throws {
        let id = 1
        try app.test(.GET, "\(basePath)/\(id)", afterResponse:  { response in
            XCTAssertEqual(response.status, .ok)
            let decodedID = try response.content.decode(Int.self)
            XCTAssert(decodedID == id)
        })
    }
}
