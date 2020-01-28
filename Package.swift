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
            targets: ["DT.Core.iOS"])
    ],
    dependencies: [
        .package(path: "Sources/Commons"),
        .package(path: "Sources/Components"),
    ],
    targets: [
        .target(
            name: "DT.Core.iOS",
            dependencies: [
                "Commons",
                "Analytics",
                "Device",
                "Extensions",
                "Interaction"
            ],
            path: "Sources")
    ]
)
