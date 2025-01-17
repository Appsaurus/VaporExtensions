// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VaporExtensions",
    platforms: [
        .macOS(.v12),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "VaporExtensions",
            targets: ["VaporExtensions"]),
        .library(
            name: "XCTVaporExtensions",
            targets: ["XCTVaporExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/Appsaurus/RoutingKitExtensions", exact: "1.0.1")
    ],
    targets: [
        .target(
            name: "VaporExtensions",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "RoutingKitExtensions", package: "RoutingKitExtensions")
            ]),
        .target(
            name: "XCTVaporExtensions",
            dependencies: [.target(name: "VaporExtensions"),
                           .product(name: "Vapor", package: "vapor"),
                           .product(name: "XCTVapor", package: "vapor")]),
        .target(name: "ExampleApp",  dependencies: [
            .product(name: "Vapor", package: "vapor")
        ],path: "./ExampleApp/App"),

        .testTarget(name: "VaporExtensionsTests", dependencies: [
            .target(name: "ExampleApp"),
            .target(name: "VaporExtensions"),
            .target(name: "XCTVaporExtensions")
        ])
    ]
)
