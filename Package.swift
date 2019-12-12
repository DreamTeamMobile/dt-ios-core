// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DT.Core.iOS",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "DT.Core.iOS",
            targets: ["DT.Core.iOS"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "DT.Core.iOS",
            path: "Source"),
        .testTarget(
            name: "DT.Core.iOSTests",
            dependencies: ["DT.Core.iOS"]),
    ]
)
