// swift-tools-version: 6.0
import PackageDescription

/// Root package so consumer apps can depend on OverloadKit via:
/// `.package(url: "https://github.com/christianberko/ios-studio.git", branch: "main")`
let package = Package(
    name: "ios-studio",
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
            name: "OverloadKit",
            path: "Packages/OverloadKit/Sources/OverloadKit"
        ),
        .testTarget(
            name: "OverloadKitTests",
            dependencies: ["OverloadKit"],
            path: "Packages/OverloadKit/Tests/OverloadKitTests"
        )
    ]
)
