//
//  RoutesBuilder+HTTPMethodSugar.swift
//  
//
//  Created by Brian Strobach on 9/8/21.
//

import Vapor
import RoutingKitExtensions

public extension RoutesBuilder {
    
    @discardableResult
    func get<R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                   use closure: @escaping (Request) async throws -> R) -> Route {
        on(.GET, path, use: closure)
        
    }
    
    @discardableResult
    func put<R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                   use closure: @escaping (Request) async throws -> R) -> Route {
        on(.PUT, path, use: closure)
    }
    
    @discardableResult
    func post<R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                    use closure: @escaping (Request) async throws -> R) -> Route {
        on(.POST, path, use: closure)
        
    }
    
    @discardableResult
    func patch<R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                     use closure: @escaping (Request) async throws -> R) -> Route {
        on(.PATCH, path, use: closure)
    }
    
    @discardableResult
    func delete<R: AsyncResponseEncodable>(_ path: PathComponentRepresentable...,
                                      use closure: @escaping (Request) async throws -> R) -> Route {
        on(.DELETE, path, use: closure)
    }
    
    @discardableResult
    func on<R: AsyncResponseEncodable>(_ method: HTTPMethod,
                                  _ path: PathComponentRepresentable...,
                                  use closure: @escaping (Request) async throws -> R) -> Route {
        on(method, path, use: closure)
        
    }
    
    @discardableResult
    func on<R: AsyncResponseEncodable>(_ method: HTTPMethod,
                                  _ path: [PathComponentRepresentable],
                                  use closure: @escaping (Request) async throws -> R) -> Route {
        on(method, path.pathComponents, use: closure)
    }
}



