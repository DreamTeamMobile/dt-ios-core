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
    name: "Components",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Components",
            targets: ["Components"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Components",
            sources: ["Device"]
        )
    ]
)
