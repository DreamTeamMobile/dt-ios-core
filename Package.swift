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
            name: "Commons",
            targets: ["Commons"]),
        .library(
            name: "Components",
            targets: ["Components"])
    ],
    targets: [
        .target(
            name: "Commons"),
        .target(
            name: "Components",
            exclude: ["Sources/Analytics/Providers", "Sources/RemoteConfig"])
    ]
)
