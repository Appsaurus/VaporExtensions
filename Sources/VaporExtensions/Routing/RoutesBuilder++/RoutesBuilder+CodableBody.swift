import Vapor
import RoutingKitExtensions

/// Extension on RoutesBuilder to provide convenient methods for handling asynchronous HTTP requests with Codable bodies
public extension RoutesBuilder {

    /// Registers a GET route with a Codable body
    ///
    /// - Parameters:
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: A variadic list of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func get<C: Codable, R: AsyncResponseEncodable>(_ body: C.Type = C.self,
                                                    at path: PathComponentRepresentable...,
                                                    use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(.GET, body, at: path, use: closure)
    }

    /// Registers a GET route with a Codable body
    ///
    /// - Parameters:
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: An array of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func get<C: Codable, R: AsyncResponseEncodable>(_ body: C.Type = C.self,
                                                    at path: [PathComponentRepresentable],
                                                    use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(.GET, body, at: path, use: closure)
    }

    /// Registers a PUT route with a Codable body
    ///
    /// - Parameters:
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: A variadic list of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func put<C: Codable, R: AsyncResponseEncodable>(_ body: C.Type = C.self,
                                                    at path: PathComponentRepresentable...,
                                                    use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(.PUT, body, at: path, use: closure)
    }

    /// Registers a PUT route with a Codable body
    ///
    /// - Parameters:
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: An array of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func put<C: Codable, R: AsyncResponseEncodable>(_ body: C.Type = C.self,
                                                    at path: [PathComponentRepresentable],
                                                    use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(.PUT, body, at: path, use: closure)
    }

    /// Registers a POST route with a Codable body
    ///
    /// - Parameters:
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: A variadic list of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func post<C: Codable, R: AsyncResponseEncodable>(_ body: C.Type = C.self,
                                                     at path: PathComponentRepresentable...,
                                                     use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(.POST, body, at: path, use: closure)
    }

    /// Registers a POST route with a Codable body
    ///
    /// - Parameters:
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: An array of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func post<C: Codable, R: AsyncResponseEncodable>(_ body: C.Type = C.self,
                                                     at path: [PathComponentRepresentable],
                                                     use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(.POST, body, at: path, use: closure)
    }

    /// Registers a PATCH route with a Codable body
    ///
    /// - Parameters:
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: A variadic list of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func patch<C: Codable, R: AsyncResponseEncodable>(_ body: C.Type = C.self,
                                                      at path: PathComponentRepresentable...,
                                                      use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(.PATCH, body, at: path, use: closure)
    }

    /// Registers a PATCH route with a Codable body
    ///
    /// - Parameters:
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: An array of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func patch<C: Codable, R: AsyncResponseEncodable>(_ body: C.Type = C.self,
                                                      at path: [PathComponentRepresentable],
                                                      use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(.PATCH, body, at: path, use: closure)
    }

    /// Registers a DELETE route with a Codable body
    ///
    /// - Parameters:
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: A variadic list of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func delete<C: Codable, R: AsyncResponseEncodable>(_ body: C.Type = C.self,
                                                       at path: PathComponentRepresentable...,
                                                       use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(.DELETE, body, at: path, use: closure)
    }

    /// Registers a DELETE route with a Codable body
    ///
    /// - Parameters:
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: An array of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func delete<C: Codable, R: AsyncResponseEncodable>(_ body: C.Type = C.self,
                                                       at path: [PathComponentRepresentable],
                                                       use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(.DELETE, body, at: path, use: closure)
    }

    /// Registers a route for a specific HTTP method with a Codable body
    ///
    /// - Parameters:
    ///   - method: The HTTP method for the route.
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: A variadic list of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func on<C: Codable, R: AsyncResponseEncodable>(_ method: HTTPMethod,
                                                   _ body: C.Type = C.self,
                                                   at path: PathComponentRepresentable...,
                                                   use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(method, body, at: path, use: closure)
    }

    /// Registers a route for a specific HTTP method with a Codable body
    ///
    /// - Parameters:
    ///   - method: The HTTP method for the route.
    ///   - body: The type of the Codable body. Default is inferred from the closure.
    ///   - path: An array of path components for the route.
    ///   - closure: The asynchronous handler for the route. It receives the request and the decoded body.
    /// - Returns: The created `Route`.
    @discardableResult
    func on<C: Codable, R: AsyncResponseEncodable>(_ method: HTTPMethod,
                                                   _ body: C.Type = C.self,
                                                   at path: [PathComponentRepresentable],
                                                   use closure: @escaping (Request, C) async throws -> R) -> Route {
        on(method, path) { request -> R in
            let decodedBody = try request.content.decode(body)
            return try await closure(request, decodedBody)
        }
    }
}
