// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "OverloadKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "OverloadKit",
            targets: ["OverloadKit"]
        )
    ],
    targets: [
        .target(
            name: "OverloadKit"
        ),
        .testTarget(
            name: "OverloadKitTests",
            dependencies: ["OverloadKit"]
        )
    ]
)
