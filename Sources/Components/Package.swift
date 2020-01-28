// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "Analytics", targets: ["Analytics"]),
        .library(name: "Device", targets: ["Device"]),
        .library(name: "Extensions", targets: ["Extensions"]),
        .library(name: "Interaction", targets: ["Interaction"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Analytics",
            dependencies: [],
            exclude: ["Providers"]),
        .target(
            name: "Device",
            dependencies: []),
        .target(
            name: "Extensions",
            dependencies: []),
        .target(
            name: "Interaction",
            dependencies: ["Device", "Extensions"])
    ]
)
