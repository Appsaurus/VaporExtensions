//
//  RoutesBuilder+Parameters.swift
//
//
//  Created by Brian Strobach on 8/2/24.
//

import Vapor
import RoutingKitExtensions

/// Extension on RoutesBuilder to provide convenient methods for handling asynchronous HTTP requests with parameters
public extension RoutesBuilder {
    
    /// Registers an asynchronous GET route with a parameter
    ///
    /// - Parameters:
    ///   - path: A variadic list of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func get<P: Parameter, R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.GET, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous GET route with a parameter
    ///
    /// - Parameters:
    ///   - path: An array of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func get<P: Parameter, R: AsyncResponseEncodable>(_ path: [PathComponentRepresentable],
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.GET, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous PUT route with a parameter
    ///
    /// - Parameters:
    ///   - path: A variadic list of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func put<P: Parameter, R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.PUT, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous PUT route with a parameter
    ///
    /// - Parameters:
    ///   - path: An array of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func put<P: Parameter, R: AsyncResponseEncodable>(_ path: [PathComponentRepresentable],
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.PUT, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous POST route with a parameter
    ///
    /// - Parameters:
    ///   - path: A variadic list of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func post<P: Parameter, R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                                       params: P.Type = P.self,
                                                       use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.POST, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous POST route with a parameter
    ///
    /// - Parameters:
    ///   - path: An array of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func post<P: Parameter, R: AsyncResponseEncodable>(_ path: [PathComponentRepresentable],
                                                       params: P.Type = P.self,
                                                       use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.POST, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous PATCH route with a parameter
    ///
    /// - Parameters:
    ///   - path: A variadic list of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func patch<P: Parameter, R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                                        params: P.Type = P.self,
                                                        use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.PATCH, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous PATCH route with a parameter
    ///
    /// - Parameters:
    ///   - path: An array of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func patch<P: Parameter, R: AsyncResponseEncodable>(_ path: [PathComponentRepresentable],
                                                        params: P.Type = P.self,
                                                        use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.PATCH, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous DELETE route with a parameter
    ///
    /// - Parameters:
    ///   - path: A variadic list of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func delete<P: Parameter, R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                                         params: P.Type = P.self,
                                                         use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.DELETE, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous DELETE route with a parameter
    ///
    /// - Parameters:
    ///   - path: An array of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func delete<P: Parameter, R: AsyncResponseEncodable>(_ path: [PathComponentRepresentable],
                                                         params: P.Type = P.self,
                                                         use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.DELETE, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous route for a specific HTTP method with a parameter
    ///
    /// - Parameters:
    ///   - method: The HTTP method for the route.
    ///   - path: A variadic list of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func on<P: Parameter, R: AsyncResponseEncodable>(_ method: HTTPMethod,
                                                     _ path: PathComponentRepresentable...,
                                                     params: P.Type = P.self,
                                                     use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(method, path, params: params, use: closure)
    }
    
    /// Registers an asynchronous route for a specific HTTP method with a parameter
    ///
    /// - Parameters:
    ///   - method: The HTTP method for the route.
    ///   - path: An array of path components for the route.
    ///   - params: The type of the parameter. Default is inferred from the closure.
    ///   - closure: The asynchronous handler for the route. It receives the request and the parameter.
    /// - Returns: The created `Route`.
    @discardableResult
    func on<P: Parameter, R: AsyncResponseEncodable>(_ method: HTTPMethod,
                                                     _ path: [PathComponentRepresentable],
                                                     params: P.Type = P.self,
                                                     use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(method, path) { request async throws -> R in
            let params = try request.parameters.next(P.self)
            return try await closure(request, params)
        }
    }
}
