// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VaporExtensions",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "VaporExtensions",
            targets: ["VaporExtensions"]),
        .library(
            name: "VaporTestUtils",
            targets: ["VaporTestUtils"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/Appsaurus/RoutingKitExtensions", .exact("1.0.1"))
    ],
    targets: [
        .target(
            name: "VaporExtensions",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "RoutingKitExtensions", package: "RoutingKitExtensions")
            ]),
        .target(
            name: "VaporTestUtils",
            dependencies: [.target(name: "VaporExtensions"),
                           .product(name: "Vapor", package: "vapor"),
                           .product(name: "XCTVapor", package: "vapor")]),
        .target(name: "ExampleApp",  dependencies: [
            .product(name: "Vapor", package: "vapor")
        ],path: "./ExampleApp/App"),

        .testTarget(name: "VaporExtensionsTests", dependencies: [
            .target(name: "ExampleApp"),
            .target(name: "VaporTestUtils"),
            .target(name: "VaporExtensions")
        ])
    ]
)
