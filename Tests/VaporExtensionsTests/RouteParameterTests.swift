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
        try app.test(.GET, "\(basePath)/\(id)") { response in
            XCTAssertEqual(response.status, .ok)
            let decodedID = try response.content.decode(Int.self)
            XCTAssert(decodedID == id)
        }
    }

    func testSubsetQueries() throws {

    }

//    func applyFilter(for property: PropertyInfo, to query: QueryBuilder<M.Database, M>, on request: Request) throws {
//        let parameter: String = property.name
//        if let queryFilter = try? request.stringKeyPathFilter(for: property.name, at: parameter) {
//            let _ = try? query.filter(queryFilter)
////            if property.type == Bool.self {
////                let _ = try? query.filterAsBool(queryFilter)
////            }
////            else  {
////                let _ = try? query.filter(queryFilter)
////            }
//        }
//    }
}


