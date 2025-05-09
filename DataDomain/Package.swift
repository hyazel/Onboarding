// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataDomain",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DataDomain",
            targets: ["DataDomain"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory", from: "2.4.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DataDomain",
            dependencies: [
                .product(name: "Factory", package: "Factory"),
            ]
        ),

    ],
    swiftLanguageModes: [.v5]
)
