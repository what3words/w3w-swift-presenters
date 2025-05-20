// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "w3w-swift-presenters",

    platforms: [
      .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],

    products: [
        .library(name: "W3WSwiftPresenters", targets: ["W3WSwiftPresenters"]),
    ],
    
    dependencies: [
      .package(url: "https://github.com/what3words/w3w-swift-core.git", branch: "staging"), //, "1.0.0"..<"2.0.0"),
      .package(url: "https://github.com/what3words/w3w-swift-themes.git", branch: "staging"), //, "1.0.0"..<"2.0.0"),
      .package(url: "https://github.com/what3words/w3w-swift-design.git", branch: "staging"), //"1.0.0" ..< "2.0.0"),
      .package(url: "git@github.com:what3words/w3w-swift-design-swiftui.git", branch: "staging"), //"1.0.0" ..< "2.0.0")
    ],
    
    targets: [
        .target(
          name: "W3WSwiftPresenters",
          dependencies: [
            //.product(name: "W3WSwiftApi", package: "w3w-swift-wrapper"),
            .product(name: "W3WSwiftCore", package: "w3w-swift-core"),
            .product(name: "W3WSwiftThemes", package: "w3w-swift-themes"),
            .product(name: "W3WSwiftDesign", package: "w3w-swift-design"),
            .product(name: "W3WSwiftDesignSwiftUI", package: "w3w-swift-design-swiftui"),
          ]
        ),
        .testTarget(name: "w3w-swift-presentersTests", dependencies: ["W3WSwiftPresenters"]),
    ]
)
