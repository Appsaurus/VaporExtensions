//
//  RoutesBuilder+CodableBody.swift
//
//
//  Created by Brian Strobach on 9/8/21.
//

import Vapor



public extension RoutesBuilder {

    @discardableResult
    func get<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
                                                 at path: PathComponentRepresentable...,
                                                 use closure: @escaping (Request, C) throws -> R) -> Route {
        on(.GET, body, at: path, use: closure)

    }

    @discardableResult
    func get<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
                                                 at path: [PathComponentRepresentable],
                                                 use closure: @escaping (Request, C) throws -> R) -> Route {
        on(.GET, body, at: path, use: closure)

    }

    @discardableResult
    func put<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
                                                 at path: PathComponentRepresentable...,
                                                 use closure: @escaping (Request, C) throws -> R) -> Route {
        on(.PUT, body, at: path, use: closure)
    }

    @discardableResult
    func put<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
                                                 at path: [PathComponentRepresentable],
                                                 use closure: @escaping (Request, C) throws -> R) -> Route {
        on(.PUT, body, at: path, use: closure)
    }

    @discardableResult
    func post<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
                                                  at path: PathComponentRepresentable...,
                                                  use closure: @escaping (Request, C) throws -> R) -> Route {
        on(.POST, body, at: path, use: closure)

    }

    @discardableResult
    func post<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
                                                  at path: [PathComponentRepresentable],
                                                  use closure: @escaping (Request, C) throws -> R) -> Route {
        on(.POST, body, at: path, use: closure)

    }

    @discardableResult
    func patch<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
                                                   at path: PathComponentRepresentable...,
                                                   use closure: @escaping (Request, C) throws -> R) -> Route {
        on(.PATCH, body, at: path, use: closure)
    }

    @discardableResult
    func patch<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
                                                   at path: [PathComponentRepresentable],
                                                   use closure: @escaping (Request, C) throws -> R) -> Route {
        on(.PATCH, body, at: path, use: closure)
    }

    @discardableResult
    func delete<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
                                                    at path: PathComponentRepresentable...,
                                                    use closure: @escaping (Request, C) throws -> R) -> Route {
        on(.DELETE, body, at: path, use: closure)
    }

    @discardableResult
    func delete<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
                                                    at path: [PathComponentRepresentable],
                                                    use closure: @escaping (Request, C) throws -> R) -> Route {
        on(.DELETE, body, at: path, use: closure)
    }

    @discardableResult
    func on<C: Codable, R: ResponseEncodable>(_ method: HTTPMethod,
                                                _ body: C.Type = C.self,
                                                at path: PathComponentRepresentable...,
                                                use closure: @escaping (Request, C) throws -> R) -> Route {
        on(method, body, at: path, use: closure)

    }

    @discardableResult
    func on<C: Codable, R: ResponseEncodable>(_ method: HTTPMethod,
                                                _ body: C.Type = C.self,
                                                at path: [PathComponentRepresentable],
                                                use closure: @escaping (Request, C) throws -> R) -> Route {
        on(method, path) { request -> R in
            let decodedBody = try request.content.decode(body)
            return try closure(request, decodedBody)
        }

    }
}

//public extension RoutesBuilder {
//
//    @discardableResult
//    func get<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
//                                                 at path: PathComponentRepresentable...,
//                                                 use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(.GET, body, at: path, use: closure)
//
//    }
//
//    @discardableResult
//    func get<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
//                                                 at path: [PathComponentRepresentable],
//                                                 use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(.GET, body, at: path, use: closure)
//
//    }
//
//    @discardableResult
//    func put<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
//                                                 at path: PathComponentRepresentable...,
//                                                 use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(.PUT, body, at: path, use: closure)
//    }
//
//    @discardableResult
//    func put<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
//                                                 at path: [PathComponentRepresentable],
//                                                 use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(.PUT, body, at: path, use: closure)
//    }
//
//    @discardableResult
//    func post<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
//                                                  at path: PathComponentRepresentable...,
//                                                  use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(.POST, body, at: path, use: closure)
//
//    }
//
//    @discardableResult
//    func post<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
//                                                  at path: [PathComponentRepresentable],
//                                                  use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(.POST, body, at: path, use: closure)
//
//    }
//
//    @discardableResult
//    func patch<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
//                                                   at path: PathComponentRepresentable...,
//                                                   use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(.PATCH, body, at: path, use: closure)
//    }
//
//    @discardableResult
//    func patch<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
//                                                   at path: [PathComponentRepresentable],
//                                                   use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(.PATCH, body, at: path, use: closure)
//    }
//
//    @discardableResult
//    func delete<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
//                                                    at path: PathComponentRepresentable...,
//                                                    use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(.DELETE, body, at: path, use: closure)
//    }
//
//    @discardableResult
//    func delete<C: Codable, R: ResponseEncodable>(_ body: C.Type = C.self,
//                                                    at path: [PathComponentRepresentable],
//                                                    use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(.DELETE, body, at: path, use: closure)
//    }
//
//    @discardableResult
//    func on<C: Codable, R: ResponseEncodable>(_ method: HTTPMethod,
//                                                _ body: C.Type = C.self,
//                                                at path: PathComponentRepresentable...,
//                                                use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(method, body, at: path, use: closure)
//
//    }
//
//    @discardableResult
//    func on<C: Codable, R: ResponseEncodable>(_ method: HTTPMethod,
//                                                _ body: C.Type = C.self,
//                                                at path: [PathComponentRepresentable],
//                                                use closure: @escaping (Request, C) throws -> R) -> Route {
//        on(method, path) { request -> R in
//            let params = try request.parameters.next(P.self)
//            return try closure(request, params)
//        }
//
//    }
//}
