//
//  RoutesBuilder+Parameters.swift
//  
//
//  Created by Brian Strobach on 9/8/21.
//

import Vapor

public extension RoutesBuilder {

    @discardableResult
    func get<P: Parameter, R: ResponseEncodable>(_ path: PathComponentRepresentable...,
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
    func post<P: Parameter, R: ResponseEncodable>(_ path: PathComponentRepresentable...,
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
    func delete<P: Parameter, R: ResponseEncodable>(_ path: PathComponentRepresentable...,
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
        on(method, path) { request -> R in
            let params = try request.parameters.next(P.self)
            return try closure(request, params)
        }

    }
}
