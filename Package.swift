// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

//let package = Package(
//    name: "VaporExtensions",
//    products: [
//        // Products define the executables and libraries produced by a package, and make them visible to other packages.
//        .library(
//            name: "VaporExtensions",
//            targets: ["VaporExtensions"]),
//    ],
//    dependencies: [
//		.package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "3.0.0")),
//    ],
//    targets: [
//        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
//        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
//        .target(
//            name: "VaporExtensions",
//            dependencies: ["Vapor"]),
//        .testTarget(
//            name: "VaporExtensionsTests",
//            dependencies: ["VaporExtensions"]),
//    ]
//)

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
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        .target(
            name: "VaporExtensions",
            dependencies: [.product(name: "Vapor", package: "vapor")]),
        .target(
            name: "VaporTestUtils",
            dependencies: [.product(name: "Vapor", package: "vapor"),
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
