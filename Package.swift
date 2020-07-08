// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Request",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "Request",
            targets: ["Request"]),
    ],
    targets: [
        .target(
            name: "Request",
            dependencies: []),
    ]
)
