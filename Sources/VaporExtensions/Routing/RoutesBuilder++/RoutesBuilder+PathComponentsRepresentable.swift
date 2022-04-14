//
//  RoutesBuilder+PathComponentRepresentable.swift
//  
//
//  Created by Brian Strobach on 9/8/21.
//

import Vapor
import RoutingKitExtensions

public extension RoutesBuilder {
    func grouped(_ pathComponent: PathComponentRepresentable...) -> RoutesBuilder {
        return grouped(pathComponent.pathComponents)
    }
}
