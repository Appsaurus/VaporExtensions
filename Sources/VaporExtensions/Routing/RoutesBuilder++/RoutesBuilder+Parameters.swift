//
//  RoutesBuilder+Parameters.swift
//
//
//  Created by Brian Strobach on 9/8/21.
//

import Vapor
import RoutingKitExtensions

public extension RoutesBuilder {
    
    @discardableResult
    func get<P: Parameter, R: ResponseEncodable>(_ path: PathComponentRepresentable...,
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(.GET, path, params: params, use: closure)
        
    }
    
    @discardableResult
    func get<P: Parameter, R: ResponseEncodable>(_ path: [PathComponentRepresentable],
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(.GET, path, params: params, use: closure)
        
    }
    
    @discardableResult
    func put<P: Parameter, R: ResponseEncodable>(_ path: PathComponentRepresentable...,
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(.PUT, path, params: params, use: closure)
    }
    
    @discardableResult
    func put<P: Parameter, R: ResponseEncodable>(_ path: [PathComponentRepresentable],
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(.PUT, path, params: params, use: closure)
    }
    
    @discardableResult
    func post<P: Parameter, R: ResponseEncodable>(_ path: PathComponentRepresentable...,
                                                       params: P.Type = P.self,
                                                       use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(.POST, path, params: params, use: closure)
        
    }
    
    @discardableResult
    func post<P: Parameter, R: ResponseEncodable>(_ path: [PathComponentRepresentable],
                                                       params: P.Type = P.self,
                                                       use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(.POST, path, params: params, use: closure)
        
    }
    
    @discardableResult
    func patch<P: Parameter, R: ResponseEncodable>(_ path: PathComponentRepresentable...,
                                                        params: P.Type = P.self,
                                                        use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(.PATCH, path, params: params, use: closure)
    }
    
    @discardableResult
    func patch<P: Parameter, R: ResponseEncodable>(_ path: [PathComponentRepresentable],
                                                        params: P.Type = P.self,
                                                        use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(.PATCH, path, params: params, use: closure)
    }
    
    @discardableResult
    func delete<P: Parameter, R: ResponseEncodable>(_ path: PathComponentRepresentable...,
                                                         params: P.Type = P.self,
                                                         use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(.DELETE, path, params: params, use: closure)
    }
    
    @discardableResult
    func delete<P: Parameter, R: ResponseEncodable>(_ path: [PathComponentRepresentable],
                                                         params: P.Type = P.self,
                                                         use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(.DELETE, path, params: params, use: closure)
    }
    
    @discardableResult
    func on<P: Parameter, R: ResponseEncodable>(_ method: HTTPMethod,
                                                     _ path: PathComponentRepresentable...,
                                                     params: P.Type = P.self,
                                                     use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(method, path, params: params, use: closure)
        
    }
    
    @discardableResult
    func on<P: Parameter, R: ResponseEncodable>(_ method: HTTPMethod,
                                                     _ path: [PathComponentRepresentable],
                                                     params: P.Type = P.self,
                                                     use closure: @escaping (Request, P.ResolvedParameter) throws -> R) -> Route {
        on(method, path.pathComponents) { request -> R in
            let params = try request.parameters.next(P.self)
            return try closure(request, params)
        }
        
    }
}


public extension RoutesBuilder {
    
    @discardableResult
    func get<P: Parameter, R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.GET, path, params: params, use: closure)
        
    }
    
    @discardableResult
    func get<P: Parameter, R: AsyncResponseEncodable>(_ path: [PathComponentRepresentable],
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.GET, path, params: params, use: closure)
        
    }
    
    @discardableResult
    func put<P: Parameter, R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.PUT, path, params: params, use: closure)
    }
    
    @discardableResult
    func put<P: Parameter, R: AsyncResponseEncodable>(_ path: [PathComponentRepresentable],
                                                      params: P.Type = P.self,
                                                      use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.PUT, path, params: params, use: closure)
    }
    
    @discardableResult
    func post<P: Parameter, R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                                       params: P.Type = P.self,
                                                       use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.POST, path, params: params, use: closure)
        
    }
    
    @discardableResult
    func post<P: Parameter, R: AsyncResponseEncodable>(_ path: [PathComponentRepresentable],
                                                       params: P.Type = P.self,
                                                       use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.POST, path, params: params, use: closure)
        
    }
    
    @discardableResult
    func patch<P: Parameter, R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                                        params: P.Type = P.self,
                                                        use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.PATCH, path, params: params, use: closure)
    }
    
    @discardableResult
    func patch<P: Parameter, R: AsyncResponseEncodable>(_ path: [PathComponentRepresentable],
                                                        params: P.Type = P.self,
                                                        use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.PATCH, path, params: params, use: closure)
    }
    
    @discardableResult
    func delete<P: Parameter, R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                                         params: P.Type = P.self,
                                                         use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.DELETE, path, params: params, use: closure)
    }
    
    @discardableResult
    func delete<P: Parameter, R: AsyncResponseEncodable>(_ path: [PathComponentRepresentable],
                                                         params: P.Type = P.self,
                                                         use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(.DELETE, path, params: params, use: closure)
    }
    
    @discardableResult
    func on<P: Parameter, R: AsyncResponseEncodable>(_ method: HTTPMethod,
                                                     _ path: PathComponentRepresentable...,
                                                     params: P.Type = P.self,
                                                     use closure: @escaping (Request, P) async throws -> R) -> Route where P.ResolvedParameter == P {
        on(method, path, params: params, use: closure)
        
    }
    
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
