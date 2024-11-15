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
    dependencies: [],
    targets: [
        .target(
            name: "TPackage",
            dependencies: [],
            path: "Sources/TPackage")
    ]
)
