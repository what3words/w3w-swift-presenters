// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "w3w-swift-presenters",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "w3w-swift-presenters",
            targets: ["w3w-swift-presenters"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "w3w-swift-presenters"),
        .testTarget(
            name: "w3w-swift-presentersTests",
            dependencies: ["w3w-swift-presenters"]
        ),
    ]
)
