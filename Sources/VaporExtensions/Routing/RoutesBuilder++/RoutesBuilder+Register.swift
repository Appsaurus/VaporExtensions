//
//  RoutesBuilder+Register.swift
//  VaporExtensions
//
//  Created by Brian Strobach on 8/26/24.
//


public extension RoutesBuilder {
    func register(_ collections: RouteCollection...) throws {
        try register(collections)
    }
    
    func register(_ collections: [RouteCollection]) throws {
        try collections.forEach { collection in
            try register(collection: collection)
        }
    }
}
