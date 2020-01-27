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
    name: "DT.Core.iOS",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "DT.Core.iOS", targets: ["DT.Core.iOS"]),
    ],
    dependencies: [
        .package(path: "Commons"),
        .package(path: "Components")
    ],
    targets: [
        .target(name: "DT.Core.iOS",
                dependencies: ["Commons","Components"],
                path: "Sources")
    ]
)
