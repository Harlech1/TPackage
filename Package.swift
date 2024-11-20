// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TPackage",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "TPackage",
            targets: ["TPackage"]),
    ],
    dependencies: [.package(url: "https://github.com/RevenueCat/purchases-ios.git", exact: "5.8.0")],
    targets: [
        .target(
            name: "TPackage",
            dependencies: [.product(name: "RevenueCat", package: "purchases-ios"), .product(name: "RevenueCatUI", package: "purchases-ios")],
            path: "Sources/TPackage")
    ]
)
