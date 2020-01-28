// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension Target {
    static func target(name: String,
                       sources: [String],
                       dependencies: [Target.Dependency] = [])
        -> Target {
            return .target(name: name,
                           dependencies: dependencies,
                           path: "Sources",
                           exclude: [],
                           sources: sources,
                           publicHeadersPath: nil,
                           cSettings: nil,
                           cxxSettings: nil,
                           swiftSettings: nil,
                           linkerSettings: nil)
        }
}

let package = Package(
    name: "Commons",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Commons",
            targets: ["Commons"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Commons",
            sources: ["Base", "Bindable", "Core", "Extensions", "Navigation"]
        )
    ]
)
