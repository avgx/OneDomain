// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "OneDomain",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
        .tvOS(.v17),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "OneDomain",
            targets: ["OneDomain"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/avgx/RequestResponse", branch: "main"),
        .package(url: "https://github.com/avgx/SafeEnum", from: "1.0.0"),
        .package(url: "https://github.com/avgx/EncodeDecode", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "OneDomain",
            dependencies: [
                .product(name: "RequestResponse", package: "RequestResponse"),
                .product(name: "SafeEnum", package: "SafeEnum"),
            ]
        ),
        .testTarget(
            name: "OneDomainTests",
            dependencies: [
                "OneDomain",
                .product(name: "EncodeDecode", package: "EncodeDecode"),
            ],
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
