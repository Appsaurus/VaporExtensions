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

    func testCodableBody() throws {

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


public struct LocationCoordinate: Codable, Equatable {
    /// The point's x coordinate.
    public var longitude: Double

    /// The point's y coordinate.
    public var latitude: Double

    /// Create a new `GISGeographicPoint2D`
    public init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}

public enum LocationCoordinateSource: String, Content, Equatable {
    case gps
    case ipAddress
    case map
    case hardcoded
}

public final class SourcedLocationCoordinate: Content, Equatable {
    public static func == (lhs: SourcedLocationCoordinate, rhs: SourcedLocationCoordinate) -> Bool {
        return lhs.coordinate == rhs.coordinate && lhs.source == rhs.source
    }

    public var source: LocationCoordinateSource
    public var timestamp = Date()
    public var coordinate: LocationCoordinate
    public var accuracy: Double?

    public init(coordinate: LocationCoordinate,
                source: LocationCoordinateSource,
                timestamp: Date = Date(),
                accuracy: Double? = nil) {
        self.coordinate = coordinate
        self.source = source
        self.timestamp = timestamp
        self.accuracy = accuracy
    }

}



public final class LocalBusinessSearch: Content {

    public var query: QueryParameter
    public var location: LocationParameter
    public var distance: Double?
    public var filters: [LocalBusinessSearch.Filter]?

    public init(query: QueryParameter,
                location: LocationParameter,
                distance: Double? = nil,
                filters: [LocalBusinessSearch.Filter]? = nil) {
        self.query = query
        self.location = location
        self.distance = distance
        self.filters = filters
    }
}

extension LocalBusinessSearch {

    public enum QueryParameter: Codable {

        case query(String)
        case suggestion(LocalBusinessSearchSuggestionDTO)

        enum CodingKeys: CodingKey {
            case query
            case suggestion
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let query = try container.decodeIfPresent(String.self, forKey: .query) {
                self = .query(query)
            } else {
                let suggestion = try container.decode(LocalBusinessSearchSuggestionDTO.self, forKey: .suggestion)
                self = .suggestion(suggestion)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .query(let value):
                try container.encode(value, forKey: .query)
            case .suggestion(let value):
                try container.encode(value, forKey: .suggestion)
            }
        }
    }

    public enum LocationParameter: Codable {

        case query(String)
        case coordinate(SourcedLocationCoordinate)

        enum CodingKeys: CodingKey {
            case query
            case coordinate
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let query = try container.decodeIfPresent(String.self, forKey: .query) {
                self = .query(query)
            }
            else {
                let coordinate = try container.decode(SourcedLocationCoordinate.self, forKey: .coordinate)
                self = .coordinate(coordinate)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .query(let value):
                try container.encode(value, forKey: .query)
            case .coordinate(let value):
                try container.encode(value, forKey: .coordinate)
            }
        }
    }

    public enum Filter: Codable {
        case openNow(Bool)
        case price(Int)
        case category(String)
        case subcategory(String)

        enum CodingKeys: CodingKey {
            case openNow
            case price
            case category
            case subcategory
            case attribute
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let openNow = try container.decodeIfPresent(Bool.self, forKey: .openNow) {
                self = .openNow(openNow)
            } else if let price = try container.decodeIfPresent(Int.self, forKey: .price) {
                self = .price(price)
            } else if let category = try container.decodeIfPresent(String.self, forKey: .category) {
                self = .category(category)
            }  else {
                let subcategory = try container.decode(String.self, forKey: .subcategory)
                self = .subcategory(subcategory)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .openNow(let value):
                try container.encode(value, forKey: .openNow)
            case .price(let value):
                try container.encode(value, forKey: .price)
            case .category(let value):
                try container.encode(value, forKey: .category)
            case .subcategory(let value):
                try container.encode(value, forKey: .subcategory)
        }
    }
}

    public enum LocalBusinessSearchSuggestionDTO: Codable, Equatable {
        public static func == (lhs: LocalBusinessSearchSuggestionDTO, rhs: LocalBusinessSearchSuggestionDTO) -> Bool {
            switch (lhs, rhs) {
                case (.keyword(let lhsValue), .keyword(let rhsValue)):
                    return lhsValue == rhsValue
                case (.category(let lhsValue), .category(let rhsValue)):
                    return lhsValue == rhsValue
                case (.subcategory(let lhsValue), .subcategory(let rhsValue)):
                    return lhsValue == rhsValue
                case (.attribute(let lhsValue), .attribute(let rhsValue)):
                    return lhsValue == rhsValue
                default: return false
            }
        }

        case keyword(String)
        case category(String)
        case subcategory(String)
        case attribute(String)

        enum CodingKeys: CodingKey {
            case keyword
            case category
            case subcategory
            case attribute
            case exactBusinessMatch
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let keyword = try container.decodeIfPresent(String.self, forKey: .keyword) {
                self = .keyword(keyword)
            } else if let category = try container.decodeIfPresent(String.self, forKey: .category) {
                self = .category(category)
            } else if let subcategory = try container.decodeIfPresent(String.self, forKey: .subcategory) {
                self = .subcategory(subcategory)
            } else {
                let attribute = try container.decode(String.self, forKey: .attribute)
                self = .attribute(attribute)
            }

        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .keyword(let value):
                try container.encode(value, forKey: .keyword)
            case .category(let value):
                try container.encode(value, forKey: .category)
            case .subcategory(let value):
                try container.encode(value, forKey: .subcategory)
            case .attribute(let value):
                try container.encode(value, forKey: .attribute)
        }
    }
    }


