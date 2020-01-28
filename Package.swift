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
            name: "DTCoreCommons",
            targets: ["DTCoreCommons"]),
        .library(
            name: "DTCoreComponents",
            targets: ["DTCoreComponents"])
    ],
    targets: [
        .target(
            name: "DTCoreCommons"),
        .target(
            name: "DTCoreComponents",
            exclude: ["Sources/Analytics/Providers", "Sources/RemoteConfig"]
        )
    ]
)
