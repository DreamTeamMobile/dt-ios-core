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
            name: "DTCore",
            targets: ["DTCore"]),
        .library(
            name: "DTCoreComponents",
            targets: ["DTCoreComponents"])
    ],
    dependencies: [
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.1.0"),
        .package(url: "https://github.com/tikhop/TPInAppReceipt.git", from: "2.3.3"),
        .package(url: "https://github.com/facebook/facebook-ios-sdk.git", from: "5.15.0")
    ],
    targets: [
        .target(
            name: "DTCore"),
        .target(
            name: "DTCoreComponents",
            dependencies: ["KeychainAccess", "TPInAppReceipt", "FacebookCore"],
            exclude: [
                "Sources/Analytics/Providers/AppCenter",
                "Sources/Analytics/Providers/AppsFlyer",
                "Sources/Analytics/Providers/Firebase",
                "Sources/RemoteConfig"
            ]
        )
    ]
)
